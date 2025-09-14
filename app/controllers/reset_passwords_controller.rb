class ResetPasswordsController < ApplicationController

  def create
    if user = User.find_by(email: params[:email].to_s.downcase)
      token = user.signed_id(purpose: 'reset_passwords', expires_in: 30.minutes)
      PasswordMailer.with(user: user, token: token).reset.deliver_later
    end
    redirect_to login_path, notice: 'Mandamos os próximos passos para resetar sua senha se o e-mail existir.'
  end

  def edit
    if params[:token].present?
      user = User.find_signed(params[:token], purpose: 'reset_passwords')
      unless user
        redirect_to login_path, alert: 'Link inválido ou expirado' and return
      end

      session[:reset_passwords_user_id] = user.id
      redirect_to password_reset_edit_path and return
    end

    @user = User.find_by(id: session[:reset_passwords_user_id])
    unless @user
      redirect_to login_path, alert: 'Link inválido ou expirado'
    end
  end

  def update
    @user = User.find_by(id: session.delete(:reset_passwords_user_id))
    unless @user
      redirect_to login_path, alert: 'Link inválido ou expirado' and return
    end

    if @user.update(password_params)
      reset_session
      redirect_to login_path, notice: 'Senha resetada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
