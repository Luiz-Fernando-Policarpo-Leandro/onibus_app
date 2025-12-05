class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_id(id: cookies.signed[:user_id])
      if Users::Authenticate.new(user, cookies[:remember_token]).call
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    if !logged_in?
      flash[:danger] = "Você precisa estar logado para acessar a página."
      redirect_to root_path
    elsif current_user.status.name != "active"
      flash[:danger] = "Você recebeu um código na sua caixa de email. Verifique, por favor."
      redirect_to verification_path unless request.path == verification_path
    end
  end

  def just_admin_permission
    unless current_user.admin?
      flash[:danger] = "Você não tem permissão"
      redirect_back fallback_location: root_path
    end
  end

  def redirect_if_logged_in
    redirect_to homePage_path if logged_in?
  end

  def admin_restriction
    @user.role.nome == "aluno" && @user.municipio == current_user.municipio
  end
end
