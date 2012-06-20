require 'open-uri'

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
