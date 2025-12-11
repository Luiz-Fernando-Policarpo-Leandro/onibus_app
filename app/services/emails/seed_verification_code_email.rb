module Emails
  class VerificationCode
    def self.call(user)
      new(user).call
    end

    def initialize(user)
      @user = user
      @code = user.verification&.code_verification
    end

    def call
      VerificationMailer.with(user: @user, code: @code).welcome_email.deliver_later
    end
  end
end
