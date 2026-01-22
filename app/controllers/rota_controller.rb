class RotaController < ApplicationController
  before_action :set_rota, only: %i[show trajetoria]
  
  def show
    @rota = Rota.find(params[:id])
    render :trajetoria
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
    @rota = Rota.find(params[:id])
  end
end