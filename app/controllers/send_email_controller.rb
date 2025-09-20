class SendEmailController < ApplicationController
  before_action :require_user

  def resending_email
    # soon
  end

  def verification_email_code
    # return if theres not a params
    unless params[:code].present?
      return
    end

    code_user = Verification.find_by(user_id: current_user.id).code_verification

    unless code_user == params[:code]
      flash[:danger] = "codigo de verificação incorreto"
      redirect_to verification_path and return
    end

    # user and the path
    @user = current_user

    # switch case
    if @user.status.name == "waiting"
      status_active = Status.find_by(name: "active")
      @user.update_column(:status_id, status_active.id)
    end

    redirect_to homePage_path
  end
end
