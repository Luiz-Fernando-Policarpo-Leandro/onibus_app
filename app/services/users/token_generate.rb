module Users
  class TokenGenerate
    
    def self.new_token
      SecureRandom.urlsafe_base64
    end

    def self.digest(token)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(token, cost: cost)
    end
  end
end
