require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validate users' do
    it "it's a valid user" do
      user = User.new(valid_user_attributes)
      expect(user).to be_valid
    end

    it "it isn't valid user" do
      %i[nome email password cpf status_id role_id municipio_id cep matricula].each do |attr|
        attrs = valid_user_attributes.dup
        attrs[attr] = nil
        user = User.new(attrs)
        expect(user).not_to be_valid, "expected user to be invalid without #{attr}"
      end
    end
  end
end
