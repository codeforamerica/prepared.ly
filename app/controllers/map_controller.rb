require 'wunderground'
require 'nokogiri'
require 'open-uri'

class MapController < ApplicationController
  def get 
  end

  def post 
    @address = params[:q]
    @coordinates = Geocoder.coordinates(@address)
    w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
    w_response = w_api.get_conditions_for(@coordinates[0].to_s + "," + @coordinates[1].to_s)
    @wind_conditions = w_response['current_observation']['wind_string']
    @relative_humidity = w_response['current_observation']['relative_humidity']

    rss = Nokogiri::XML(open('http://tfsfrp.tamu.edu/wildfires/BurnBan.xml'))
    rss.encoding = 'utf-8'
    counties = rss.css('rss channel item description').text
    @counties_list = '\'' + counties.strip.split(', ').join("\', \'") + '\''
  end
end
