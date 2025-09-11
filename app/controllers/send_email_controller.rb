class SendEmailController < ApplicationController
  before_action :require_user
  before_action :verify_status


  def verification_email_code
    if params[:code].present?

      code_user = Verification.find_by(user_id: current_user.id).code_verification

      if code_user == params[:code]
        @user = current_user
        status_active = Status.find_by(name: "active")
        @user.update_column(:status_id, status_active.id)

        redirect_to homePage_path and return
      end

      flash[:danger] = "codigo de verificação incorreto"
      redirect_to verification_path
    end
  end

  def reset_password
  end

  private

  def verify_status
    # test password reset
    # if current_user.status.name == "active"
    #  redirect_to homePage_path and return
    # end
  end
end
