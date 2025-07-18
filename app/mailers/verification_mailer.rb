class VerificationMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @code = Verification.find_by(user_id: @user.id)&.code_verification
    mail(to: @user.email, subject: "Seu codigo de verificação")
  end

  def new_code_verification_email
  end
end
