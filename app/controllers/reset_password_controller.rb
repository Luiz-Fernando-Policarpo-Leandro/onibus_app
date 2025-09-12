class ResetPasswordController < ApplicationController
   before_action :require_user
   # before_action :require_reset_password_status

   def new_password
     if current_user.update(password_params)
       flash[:success] = "Senha alterada com sucesso."
       redirect_to login_path
     else
       flash.now[:danger] = "Não foi possível alterar a senha."
       render :index, status: :unprocessable_entity
     end
   end

   private

   def password_params
     params.require(:password_reset).permit(:password, :password_confirmation)
   end

   def require_reset_password_status
      unless current_user.status.name == "reset password"
         redirect_to homePage_path and return
      end
   end
end
