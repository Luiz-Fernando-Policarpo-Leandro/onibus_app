class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [ :new ]
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)

      if params[:session][:remember_me] == "1"
        remember(user)
      else
        forget(user)
      end

      flash[:success] = "Login bem-sucedido!"

      redirect_to root_path
    else
      flash.now[:danger] = "Email ou senha inválidos." # flash.now desaparece na próxima requisição
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Logout realizado com sucesso."
    redirect_to root_path, status: :see_other
  end


end
