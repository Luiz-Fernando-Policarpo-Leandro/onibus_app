class VerificationMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @code = params[:code]
    mail(to: @user.email, subject: "Seu codigo de verificação")
  end
end
