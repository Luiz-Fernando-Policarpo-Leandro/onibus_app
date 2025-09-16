module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    Users::Remember.new(user).call
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    Users::Forget.new(user).call
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
