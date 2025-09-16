module Users
  class Remember
    def initialize(user)
      @user = user
    end

    def call
      remember
    end

    private

    def remember
      token = Users::TokenGenerate.new_token
      @user.remember_token = token
      @user.update_column(:remember_digest, Users::TokenGenerate.digest(token))
    end
  end
end
