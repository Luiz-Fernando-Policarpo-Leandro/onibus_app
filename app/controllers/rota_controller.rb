class RotaController < ApplicationController
  def trajetoria
    rota = Rota.find(params[:id])
    trajetoria = Rotas::OpenRouteService.gerar_trajetoria!(rota)

    render json: trajetoria.geom
  end

  def show
  end
end
