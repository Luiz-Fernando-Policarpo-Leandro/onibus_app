class PasswordMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
    @user = params[:user]
    @token = params[:token]
    @url = password_reset_edit_url(token: @token)
    mail(to: @user.email, subject: "Redefinição de senha")
  end
end
