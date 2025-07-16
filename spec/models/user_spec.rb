require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validate users' do
    let(:valid_attributes) do
      {
        nome: "Commun Name",
        email: 'test@gmail.com',
        password: "HJtJ1232@",
        cpf: "12345678910",
        role_id: Role.find_or_create_by(nome: "aluno").id,
        status_id: Status.find_or_create_by(name: "active").id,
        municipio_id: Municipio.find_or_create_by(nome: "Maceió").id,
        cep: "57035000",
        matricula: "123456789"
      }
    end

    it "it's a valid user" do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end

    it "it isn't valid user" do
      %i[nome email password cpf status_id role_id municipio_id cep matricula].each do |attr|
        attrs = valid_attributes.dup
        puts("sem o #{attr}: #{attrs[attr]}")
        attrs[attr] = nil
        user = User.new(attrs)
        expect(user).not_to be_valid, "expected user to be invalid without #{attr}"
      end
    end
  end
end
