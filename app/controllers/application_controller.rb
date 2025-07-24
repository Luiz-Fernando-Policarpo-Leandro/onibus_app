class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    if !logged_in?
      flash[:danger] = "Você precisa estar logado para acessar esta página."
      redirect_to root_path
    elsif current_user.status.name == "waiting"
      flash[:danger] = "Você recebeu um código na sua caixa de email. Verifique, por favor."
      redirect_to verification_path
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
end
