module Users
  class Authenticate
    def initialize(user, token)
      @user = user
      @token = token
    end

    def call
      authenticated?
    end

    private
     # check if the token is on the database
     def authenticated?
        return false if @user&.remember_digest.nil?
        BCrypt::Password.new(@user.remember_digest).is_password?(@token)
     end
  end
end
