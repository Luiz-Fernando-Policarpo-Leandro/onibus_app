class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.status = Status.find_by(name: "waiting") # define estatus como "waiting"
    @user.build_verification(code_verification: SecureRandom.hex(4))

    if @user.save
      session[:user_id] = @user.id # o usuário é logado após o registro
      flash[:success] = "Bem-vindo ao app, #{@user.email}!"
      redirect_to root_path # Redireciona para a página inicial
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
