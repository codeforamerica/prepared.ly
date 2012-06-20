require 'open-uri'

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


