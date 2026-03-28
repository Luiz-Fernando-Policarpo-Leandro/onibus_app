class RotaController < ApplicationController
  before_action :set_rota, only: %i[show trajetoria]

  def show
  end

  def trajetoria
    begin
      trajetoria = Rotas::OpenRouteService.gerar_trajetoria!(@rota)
      render json: trajetoria.geom, status: :ok
    rescue => e
      render json: { erro: e.message }, status: :unprocessable_entity
    end
  end

  private

  def set_rota
    params_id = params[:id] ? params[:id] : 1
    @rota = Rota.find(params_id)
  end
end