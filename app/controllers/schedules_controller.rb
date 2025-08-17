class SchedulesController < ApplicationController
  before_action :require_user

  def show
    # soon
  end

  private

  def schedule_params
    require(:schedule).permit(:user_id, :horario_saida, :horario_volta, :municipio_id, :faculdade_id)
  end
end
