require 'wunderground'
require 'nokogiri'
require 'open-uri'

class MapController < ApplicationController
  def get 
  end

  def post 
    address_str = params[:q]
    coordinates = Geocoder.coordinates(address_str)
    @address = Address.create(:address => address_str, :latlon => 'POINT(' + coordinates[1].to_s + ' ' + coordinates[0].to_s + ')')

    # Closest Fire Station
    @cfs = FireStation.order("ST_Distance(latlon, '" + @address.latlon.to_s + "') LIMIT 1")[0]
    @distance = "%.02f" % @address.latlon.distance(@cfs.latlon)

    # Weather Conditions
    w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
    w_response = w_api.get_conditions_for(@address.latlon.y.to_s + "," + @address.latlon.x.to_s)
    @wind_conditions = w_response['current_observation']['wind_string']
    @relative_humidity = w_response['current_observation']['relative_humidity']

    # Counties with a Burn Ban
    rss = Nokogiri::XML(open('http://tfsfrp.tamu.edu/wildfires/BurnBan.xml'))
    rss.encoding = 'utf-8'
    counties = rss.css('rss channel item description').text
    @counties_list = '\'' + counties.strip.split(', ').join("\', \'") + '\''
    @inside_burnban = nil

  end
end
