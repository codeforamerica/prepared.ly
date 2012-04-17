require 'wunderground'

class MapController < ApplicationController
  def index
    @address = params[:q]
    @coordinates = Geocoder.coordinates(@address)
    w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
    w_response = w_api.get_conditions_for(@coordinates[0].to_s + "," + @coordinates[1].to_s)
    @wind_conditions = w_response['current_observation']['wind_string']
    @relative_humidity = w_response['current_observation']['relative_humidity']
  end
end
