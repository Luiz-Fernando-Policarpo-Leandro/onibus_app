module Users
  class GenerateCode
    def self.call(user)
      new(user).call
    end

    def initialize(user)
      @user = user
    end

    def call
      verification = @user.verification || @user.build_verification
      verification.code_verification = SecureRandom.hex(4)
      verification.save!
    end
  end
end
