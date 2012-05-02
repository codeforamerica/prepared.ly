class County < ActiveRecord::Base
  attr_accessible :geometry, :name
  set_rgeo_factory_for_column(:geometry, RGeo::Geographic.spherical_factory(:srid => 4326))
end
