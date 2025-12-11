module Users
  class CreateUser
    Result = Struct.new(:success?, :user)

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      user = User.new(@params)

      apply_defaults(user)

      if user.save
        Emails::VerificationCode.call(user)
        Result.new(true, user)
      else
        Result.new(false, user)
      end
    end

    private

    def apply_defaults(user)
      user.status = Status.waiting
      user.build_verification(code_verification: SecureRandom.hex(4))
    end
  end
end
