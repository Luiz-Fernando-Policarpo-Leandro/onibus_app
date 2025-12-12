class SendEmailController < ApplicationController
  before_action :require_user, except: [ :resend_email ]

  def resend_email
    return root_path unless logged_in?

    user = params[:user] ? User.find(params[:user]) : current_user

    ActiveRecord::Base.transaction do
      user.prepare_verification_code
      user.save!
    end

    Notifications::SeedVerificationCodeEmail.call(user)

    flash[:success] = "Código reenviado."
    redirect_to verification_path
  end

  def verification_email_code
    return unless params[:code].present?

    stored_code = current_user.verification&.code_verification

    unless stored_code == params[:code]
      flash[:danger] = "Código de verificação incorreto."
      redirect_to verification_path and return
    end

    if current_user.status == Status.waiting
      current_user.update!(status: Status.active)
    end

    redirect_to homePage_path
  end
end
