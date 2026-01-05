require "net/http"
require "json"

module Rotas
  class OpenRouteService
    BASE_URL = "https://api.openrouteservice.org/v2/directions/driving-car"

    def self.gerar_trajetoria!(rota)
      # evita chamadas inúteis
      if rota.trajetoria_atual.present?
        return rota.trajetoria_atual
      end

      origem  = rota.municipio_origem
      destino = rota.municipio_destino

      unless origem.latitude && origem.longitude &&
             destino.latitude && destino.longitude
        raise "Município sem coordenadas"
      end

      uri = URI(BASE_URL)
      uri.query = URI.encode_www_form(
        api_key: ENV.fetch("OPENROUTE_API_KEY"),
        start: "#{origem.longitude},#{origem.latitude}",
        end:   "#{destino.longitude},#{destino.latitude}"
      )

      response = Net::HTTP.get_response(uri)

      unless response.is_a?(Net::HTTPSuccess)
        raise "Erro OpenRouteService: #{response.code}"
      end

      json = JSON.parse(response.body)

      geometry = json.dig("features", 0, "geometry")
      raise "Geometria inválida" unless geometry

      rota.rota_trajetorias.create!(
        geom: geometry
      )
    end
  end
end
