require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validate users' do
    it "it's a valid email and password" do
      status = Status.create!(name:"active")
      user = User.new(email: 'test@gmail.com', password: "HJtJ1232@", status_id: status.id)
      expect(user).to be_valid
    end

    it "it isn't a valid if thero no email, password or status_id" do
      status = Status.create!(name: 'active')
      user_email = User.new(password: 'HJtJ1232@',status_id: status.id)
      user_password = User.new(email: 'erro@gmail.com', status_id: status.id)
      user_status = User.new(email: 'erro@gmail.com', password: "HJtJ1232@")

      expect(user_email).not_to be_valid
      expect(user_password).not_to be_valid
      expect(user_status).not_to be_valid 

    end
  end
end
