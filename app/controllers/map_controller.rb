require 'nokogiri'
require 'open-uri'
require 'wunderground'

class TFS
  include HTTParty

  base_uri 'http://ags1.dtsgis.com/ArcGIS/rest/services/v3scfa'


  def self.get_token()
    response = get('https://agstx.dtsagile.com/ArcGIS/Tokens',
      :query => {
        :request => "gettoken",
        :username => ENV['TXWRAP_USER'],
        :password => ENV['TXWRAP_PASS'],
        :clientId => "ref.http://www.prepared.ly",
        :expiration => "1440"
      }
    )

    if response != nil    
      return response.body
    else 
      return nil
    end
  end

  def self.risk_assessment(latlon)

    token = self.get_token()

    response = get('/RiskAssessment/MapServer/identify',
      :headers => {
        "Referer" => "http://www.prepared.ly"
        },
      :query => {
        :geometryType => "esriGeometryPoint",
        :geometry => "{x: " + latlon.x.to_s + ", y: " + latlon.y.to_s + "}",
        :sr => 4326,
        :layers => 'all',
        :tolerance => 3,
        :mapExtent => '-98,30,-97,31',
        :imageDisplay => '572,740,96',
        :returnGeometry => true,
        :f => 'pjson',
        :token => token
      }
    )

    if response != nil
      json_response = JSON.parse(response.body)
      if json_response['results'].length > 0
        return json_response['results'][0]['attributes']['Pixel Value'].to_i
     else
       return nil
      end
    end
  end
end

class MapController < ApplicationController
  #after_filter :post, only => [:post, :nws_warnings]

  def post
    setupMapInfo()
    @address_str = params[:q]
    respond_to do |format|
       #format.html
       format.js
     end

  end

  def setupMapInfo
    @address_str = params[:q]
    #to get only the lat lon, use line below and remove following five lines 
    #@coordinates = Geocoder.coordinates(@address_str)
    @geocode = Geocoder.search(@address_str).to_json
    @geocode_response = JSON.parse(@geocode)
    @county = @geocode_response[0]['data']['address_components'][4]['long_name']
    @coordinates_array = @geocode_response[0]['data']['geometry']['location'].flatten
    @coordinates = [@coordinates_array[1], @coordinates_array[3]]

    if @coordinates
      @address = Address.find_or_create_by_address(:address => @address_str, 
        :latlon => 'POINT(' + @coordinates[1].to_s + ' ' + @coordinates[0].to_s + ')')
      session[:last_address_id] = @address.id

      # Fire Station
      @fs = FireStation.all() #order("ST_Distance(latlon, '" + @address.latlon.to_s + "') LIMIT 1")[0]
      # d_meters = @address.latlon.distance(@cfs.latlon)
      # @distance = "%.02f" % (d_meters/1609.344)
      # Weather Conditions
      w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
      w_response = w_api.get_conditions_for(@address.latlon.y.to_s + "," + @address.latlon.x.to_s)
      @wind_conditions = w_response['current_observation']['wind_string']
      @relative_humidity = w_response['current_observation']['relative_humidity']

      # Counties with a Burn Ban
      rss = Nokogiri::XML(open('http://tfsfrp.tamu.edu/wildfires/BurnBan.xml'))
      rss.encoding = 'utf-8'
      counties_text = rss.css('rss channel item description').text
      counties_array = counties_text.strip.split(', ')
      @counties_list = '\'' + counties_array.join("\', \'") + '\''
      #use single call to geocoder above and get county back instead of using CartoDB class and API call to get *nearest* county (which sometimes matched 'yes' for a non-TX county)
      if (counties_array.include?(@county))
        @inside_burnban = 'yes'
      else
        @inside_burnban = 'no'
      end
      @burnban_updated = rss.css('rss channel item title').text.split('-')[1]

      # Counties with a National Weather Service warning
      doc = Nokogiri::XML(open('http://alerts.weather.gov/cap/tx.php?x=0'))
      doc.remove_namespaces!
      @warnings = []
      @inside_nws = 'no'
      doc.css('entry').each do |node|
        each_county_array = node.css('areaDesc').text.strip.split('; ')
        if each_county_array.include?(@county.capitalize)
          @inside_nws = 'yes'
          @warnings.push(node)
        end
      end

      # Risk Assessment Level
      if TFS.risk_assessment(@address.latlon) == nil
        @risk_text = "Not available at this time"
      else
        @risk_level = TFS.risk_assessment(@address.latlon)
        risk_text_mapping = Hash.new {0}
        risk_text_mapping[0] = "Very Low"
        risk_text_mapping[1] = "Very Low"
        risk_text_mapping[2] = "Low"
        risk_text_mapping[3] = "Low"
        risk_text_mapping[4] = "Moderate"
        risk_text_mapping[5] = "Moderate"
        risk_text_mapping[6] = "High"
        risk_text_mapping[7] = "High"
        risk_text_mapping[8] = "Very High"
        risk_text_mapping[9] = "Very High"
        @risk_text = risk_text_mapping[@risk_level]
       end
    end
  end


  def mapinfo
    setupMapInfo()
    render :json => {:risk_level => @risk_level,
      :risk_text => @risk_text,
      :address => @address_str,
      :warnings => @warnings,
      :inside_nws => @inside_nws,
      :location => {:lat => @address.latlon.y, :lon => @address.latlon.x},
      :wind_conditions => @wind_conditions,
      :relative_humidity => @relative_humidity,
      :inside_burnban => @inside_burnban}

    #render :partial => 'map/mapinfo'


  end

end
