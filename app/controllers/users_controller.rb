class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[ new ]
  before_action :require_user, except: %i[new create]
  before_action :just_admin_permission, only: %i[ index show destroy ]

  # /users/:id/edit

  def edit
    if params[:id].present?
      just_admin_permission
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def index
    if params[:filter_by_municipio].present? && current_user&.admin?
      aluno_role = Role.find_by(nome: "aluno")
      @users = User.where(
        municipio_id: current_user.municipio_id,
        role_id: aluno_role.id).order(:nome)
    else
      @users = User.all.order(:nome)
    end
  end

  # /users/1
  def show
    if params[:id]
      @user = User.find_by(id: params[:id])
    else
      @user = current_user
    end
    render :profileUser
  end

  def new
    @user = User.new
    @user.phones.build
  end

  def create
    @user = User.new(user_params)
    @user.status_id = Status.find_by(name: "waiting").id # define estatus como "waiting"

    @user.municipio_id = user_params[:municipio_id]

    @user.build_verification(code_verification: SecureRandom.hex(4))

    if @user.save
      session[:user_id] = @user.id # o usuário é logado após o registro
      VerificationMailer.with(user: @user).welcome_email.deliver_later
      flash[:success] = "Bem-vindo ao app, #{@user.email}!"
      redirect_to root_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if params[:id].present?
      @user = User.find_by(id: params[:id])
      unless current_user.admin? || @user == current_user
        flash[:danger] = "Você não tem permissão para realizar esta ação."
        redirect_to root_path and return
      end
      flash_mensager = "O perfil do usuário"
    else
      @user = current_user
      flash_mensager = "seu perfil, caro"
    end

    if @user.update(user_params)
      flash[:success] = "#{flash_mensager} #{@user.nome}, foi atualizado com sucesso!"

      if params[:id].present? && current_user.admin? && @user != current_user
        redirect_to user_path(@user)
      else
        redirect_to profileUser_path
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_email
    if params[:email].present?
      if current_user.update(email: params[:email])
        flash[:success] = "Email atualizado com sucesso"
        redirect_to root_path
      else
        flash.now[:error] = "Erro ao atualizar email"
        render :update_email, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if admin_restriction
      if @user.destroy
        flash[:success] = "Usuário #{@user.nome} excluído com sucesso."
      else
        flash[:danger] = "Não foi possível excluir o usuário #{@user.nome}."
      end
    else
      flash[:danger] = "você não pode deletar alguem que não seja do seu municipio ou outro administrador"
    end
    redirect_to users_path
  end


  private

  def user_params
    params.require(:user).permit(
      :nome, :email, :password, :password_confirmation, :municipio_id, :cpf, :cep, :matricula, :role_id,
      phones_attributes: [ :id, :number, :_destroy ],
      schedules_attributes: [ :id, :horario_saida, :horario_volta, :municipio_id, :faculdade_id, :_destroy ]
      )
  end
end
