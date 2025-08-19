class SchedulesController < ApplicationController
  before_action :require_user
  before_action :just_admin_permission, only: [ :show ]
  before_action :set_schedule, only: [ :edit, :destroy, :show ]

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = "Agendamento criado com sucesso!"
      redirect_to schedules_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def schedule_user
    @schedules = current_user.schedules
  end

  def edit
    if params[:id].present?
      just_admin_permission
      @schedules = User.find(params[:id]).schedules
    else
      @schedules = current_user.schedules
    end
  end

  def show
  end

  def destroy
    if @schedule
      @schedule.destroy
      flash[:success] = "Agenda deletada com sucesso."
    else
      flash[:danger] = "Agenda não encontrada."
    end
      redirect_to scheduleUser_path
    end


  private

  def set_schedule
    @schedule = Schedule.find(params[:id]) if params[:id].present?
  end

  def schedule_params
    params.require(:schedule).permit(:user_id, :horario_saida, :horario_volta, :municipio_id, :faculdade_id)
  end
end
