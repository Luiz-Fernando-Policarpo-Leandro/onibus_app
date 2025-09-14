module UserHelper
  def valid_user_attributes
    {
      nome: "Commun Name",
      email: 'test@gmail.com',
      password: "HJtJ1232@",
      password_confirmation: "HJtJ1232@",
      cpf: "12345678910",
      role_id: Role.find_or_create_by(nome: "aluno").id,
      status_id: Status.find_or_create_by(name: "active").id,
      municipio_id: Municipio.find_or_create_by(nome: "Maceió").id,
      cep: "57035000",
      matricula: "123456789"
    }
  end

  def session_params_for(user)
      {
        session: {
        email: user.email,
        password: user.password
        }
      }
  end
end
