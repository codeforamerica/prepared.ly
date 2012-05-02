require 'csv'
require 'open-uri'

class FireStation < ActiveRecord::Base
  attr_accessible :address, :latlon, :zip
  set_rgeo_factory_for_column(:latlon, RGeo::Geographic.spherical_factory(:srid => 4326))

  def self.populate
    csv_text = nil
    open('https://raw.github.com/gist/2504610/76e47ca52136f2d6a88585cf8755e887795ee0ab/afd_stations.csv') do |f|
      csv_text = f.read()
    end
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      fs = FireStation.create
      fs.address = row[2]
      fs.zip = row[5].to_i
      fs.latlon = "POINT(" + row[7] + " " + row[6] +")"
      puts fs.address, fs.zip, fs.latlon
      fs.save!
    end
  end
end
