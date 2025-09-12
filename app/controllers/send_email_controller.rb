class SendEmailController < ApplicationController
  before_action :require_user
  before_action :verify_status


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
    path_url = homePage_path

    # switch case
    case @user.status.name
    when "waiting"
        status_active = Status.find_by(name: "active")
        @user.update_column(:status_id, status_active.id)

    when "reset password"
        path_url = reset_password_path
    end

    redirect_to path_url
  end

  private

  def verify_status
    # test password reset
    # if current_user.status.name == "active"
    # redirect_to homePage_path and return
    # end
  end
end
