class MapController < ApplicationController
  def index
    @address = params[:q]
    @coordinates = Geocoder.coordinates(@address)
  end
end
