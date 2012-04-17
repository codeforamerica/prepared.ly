require 'wunderground'

class MapController < ApplicationController
  def index
    @address = params[:q]
    @coordinates = Geocoder.coordinates(@address)
    w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
    w_response = w_api.get_forecast_for(@coordinates[0].to_s + "," + @coordinates[1].to_s)
    @weather = w_response['forecast']['txt_forecast']['forecastday'][0]['fcttext']
  end
end
