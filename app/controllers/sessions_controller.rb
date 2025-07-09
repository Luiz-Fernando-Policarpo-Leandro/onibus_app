class SessionsController < ApplicationController
  def new
    # Renderiza o formulário de login
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id # Armazena o ID do usuário na sessão
      flash[:success] = "Login bem-sucedido!"
      redirect_to root_path
    else
      flash.now[:danger] = "Email ou senha inválidos." # flash.now desaparece na próxima requisição
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil # Limpa a sessão do usuário
    flash[:success] = "Logout realizado com sucesso."
    redirect_to root_path, status: :see_other # Redireciona para a página inicial com status 303 (See Other)
  end
end