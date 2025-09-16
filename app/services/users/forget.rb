module Users
   class Forget
      def initialize(user)
         @user = user
      end

      def call
         forget_user
      end

      private

      def forget_user
         @user.update_column(:remember_digest, nil)
      end
   end
end
