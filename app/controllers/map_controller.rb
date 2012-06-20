require 'nokogiri'
require 'open-uri'
require 'wunderground'

class TFS
  include HTTParty

  base_uri 'http://ags1.dtsgis.com/ArcGIS/rest/services/v2'

  def self.risk_assessment(latlon)
    response = get('/RiskAssessment/MapServer/identify',
      :query => {
        :geometryType => "esriGeometryPoint",
        :geometry => "{x: " + latlon.x.to_s + ", y: " + latlon.y.to_s + "}",
        :sr => 4326,
        :layers => 'all',
        :tolerance => 3,
        :mapExtent => '-98,30,-97,31',
        :imageDisplay => '572,740,96',
        :returnGeometry => true,
        :f => 'pjson'
      }
    )

    json_response = JSON.parse(response.body)
    print json_response
    if json_response['results'].length > 0
      return json_response['results'][0]['attributes']['Pixel Value'].to_i
    else
      return nil
    end
  end
end

class CartoDB
  include HTTParty

  base_uri 'http://tinio.cartodb.com/api/v2'

  def self.current_county(latlon)
    response = get('/sql',
      :query => {
        :q => "SELECT name FROM cntys04 ORDER BY ST_Distance(ST_GeomFromText('POINT(" + latlon.x.to_s + " " + latlon.y.to_s + ")',4326), the_geom) LIMIT 1;"
      }
    )
    json_response = JSON.parse(response.body)
    return json_response['rows'][0]['name']
  end
end

class MapController < ApplicationController
  def get
    @user = current_user
    @completed_tasks = CompletedTask.find_all_by_user_id(@user.id) # returns an array
  end

  def post
    @address_str = params[:q]
    @coordinates = Geocoder.coordinates(@address_str)
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
      if counties_array.include?(CartoDB.current_county(@address.latlon))
        @inside_burnban = 'yes' 
      else
        @inside_burnban = 'no'
      end

      # Risk Assessment Level
      @risk_level = TFS.risk_assessment(@address.latlon)
      risk_text_mapping = Hash.new {0}
      risk_text_mapping[0] = "Minimal"
      risk_text_mapping[1] = "Very Low"
      risk_text_mapping[2] = "Very Low to Low"
      risk_text_mapping[3] = "Low"
      risk_text_mapping[4] = "Low to Moderate"
      risk_text_mapping[5] = "Moderate"
      risk_text_mapping[6] = "Moderate to High"
      risk_text_mapping[7] = "High"
      risk_text_mapping[8] = "High to Very High"
      risk_text_mapping[9] = "Very High"
      @risk_text = risk_text_mapping[@risk_level]
    end
  end
end
