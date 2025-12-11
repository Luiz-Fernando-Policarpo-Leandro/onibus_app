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
      user.status = Status.waiting

      user.prepare_verification_code

      if user.save
        Notifications::SeedVerificationCodeEmail.call(user)
        Result.new(true, user)
      else
        Result.new(false, user)
      end
    end
  end
end
