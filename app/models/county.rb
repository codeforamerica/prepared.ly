require 'rgeo/geo_json'

class County < ActiveRecord::Base
  attr_accessible :geometry, :name
  set_rgeo_factory_for_column(:geometry, RGeo::Geographic.spherical_factory(:srid => 4326))

  def self.populate
    factory = County.rgeo_factory_for_column(:geometry)
    file = File.open("/Users/cfa/code/codeforamerica/prepared.ly/data/texas_counties/cntys04.json")
    contents = file.read
    records = RGeo::GeoJSON.decode(contents, :json_parser => :json, :geo_factory => factory)
    records.each do |record|
      county = County.create
      county.name = record['NAME']
      county.geometry = record.geometry
      county.save!
      puts record['NAME']
    end
  end
end
