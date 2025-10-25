require 'open-uri'  # Requisições HTTP
require 'json'      # Parse JSON

puts "===> Criando dados iniciais..."

# =========================
# 1. Dias da Semana
# =========================
puts "-> Criando dias da semana..."
%w[segunda terca quarta quinta sexta sabado].each do |dia|
  Weekday.find_or_create_by(name: dia)
end

# =========================
# 2. Status
# =========================
puts "-> Criando status de usuário..."
[ "active", "block", "waiting", "reset password" ].each do |status_name|
  Status.find_or_create_by(name: status_name)
end

# =========================
# 3. Municípios + Faculdades
# =========================
puts "-> Buscando municípios de AL no IBGE..."
url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/27/municipios'
municipios = JSON.parse(URI.open(url).read)

puts "-> Criando municípios e faculdades..."
municipios.each do |m|
  nome = m['nome']
  municipio = Municipio.find_or_create_by(nome: nome)

  2.times do |i|
    Faculdade.find_or_create_by(
      nome: "Faculdade #{i + 1} de #{nome}",
      municipio_id: municipio.id
    )
  end
end

# =========================
# 4. CEPs fictícios
# =========================
CEPS_POR_MUNICIPIO = {
  "Maceió"   => %w[57000000 57035000 57038000 57040000],
  "Cajueiro" => %w[57770000 57771000]
  # "Arapiraca" => %w[57300000 57302020 57310005],
  # "Penedo"    => %w[57200000 57202000],
  # "Delmiro Gouveia" => %w[57480000]
}

def cep_aleatorio(municipio)
  CEPS_POR_MUNICIPIO.fetch(municipio, [ "57000-000" ]).sample
end

# =========================
# 5. Roles
# =========================

puts "-> Criando roles..."
%w[admin aluno motorista].each do |role_name|
  Role.find_or_create_by(nome: role_name)
end

# =========================
# 6. Usuários
# =========================
dic_status_id = {
  admin: Role.find_by(nome: "admin").id,
  aluno: Role.find_by(nome: "aluno").id,
  motorista: Role.find_by(nome: "motorista").id
}

puts "-> Criando usuários admin..."
users_adm = [
  {
    nome: "Gabriel Ramos",
    email: "user_adm_master1@gmail.com",
    password: "@AdmPassword123",
    cep: cep_aleatorio("Maceió"),
    cpf: "12345678914",
    role_id: dic_status_id[:admin],
    municipio_id: Municipio.find_by(nome: "Maceió").id,
    matricula: "123456789",
    telefones: %w[82912345678 82987654321]
  },
  {
    nome: "Mario Penedo",
    email: "user_adm_master2@gmail.com",
    password: "@AdmPassword123",
    cep: cep_aleatorio("Cajueiro"),
    cpf: "12345678910",
    role_id: dic_status_id[:admin],
    municipio_id: Municipio.find_by(nome: "Cajueiro").id,
    matricula: "123456789",
    telefones: %w[82911223344]
  }
]

puts "-> Criando motoristas"
time_test_cnh = Time.zone.parse("#{Time.now.year + 5}-09-17")

users_motorista = [
    {
    nome: "Gilberto",
    email: "user_motorista@gmail.com",
    password: "@AdmPassword123",
    cep: cep_aleatorio("Maceió"),
    cpf: "12345678917",
    role_id: dic_status_id[:motorista],
    municipio_id: Municipio.find_by(nome: "Maceió").id,
    matricula: "123456789",
    cnh: "123456789",
    categoria_cnh: "D",
    validade_cnh: time_test_cnh,
    telefones: %w[82912345678 82987654321]
  },
  { nome: "João",
    email: "joao_motorista@gmail.com",
    password: "@PassWordMotorista456",
    cep: cep_aleatorio("Rio de Janeiro"),
    cpf: "98765432100",
    role_id: dic_status_id[:motorista],
    municipio_id: Municipio.find_by(nome: "Paripueira").id,
    matricula: "987654321",
    cnh: "987654321",
    categoria_cnh: "D",
    validade_cnh: time_test_cnh,
    telefones: %w[21998765432 21912345678]
  }
]

users = users_adm + users_motorista

faculdades = Faculdade.order("RAND()").limit(users_adm.length)


users.each_with_index do |user_attrs, idx|
  telefones = user_attrs.delete(:telefones)

  # retirando coisas desnecessarias
  motorista_attrs = user_attrs.slice(:cnh, :categoria_cnh, :validade_cnh)
  user_attrs.except!(:cnh, :categoria_cnh, :validade_cnh)


  user = User.find_or_initialize_by(email: user_attrs[:email])
  user.assign_attributes(user_attrs.merge(status_id: Status.find_by(name: "active").id))
  user.save!

  # Associa faculdade se for aluno
  case user_attrs[:role_id]
  when dic_status_id[:aluno]
    user.faculdades << faculdades[idx] if faculdades[idx].present?
  when dic_status_id[:motorista]
    user.create_motorista(motorista_attrs)
  end

  # Associa telefones
  telefones.each do |num|
    Phone.find_or_create_by(user_id: user.id, number: num)
  end
end

# =========================
# 7. Modelos de ônibus
# =========================
puts "-> Criando modelos de ônibus..."
modelos_onibus = {
  "Vision 2000"   => "Eterna Indústrias",
  "AetherGlide"   => "Vanguard Motors",
  "Stratos XL"    => "Horizon Transports",
  "UrbanLink 50"  => "Cetro Veículos",
  "Trilha Master" => "Nômade Veículos"
}

modelos_onibus.each do |nome, fabricante|
  Modelo.find_or_create_by!(nome: nome, fabricante: fabricante)
end

# =========================
# 8. Onibus
# =========================
puts "-> Criando ônibus..."
rad = Random.new

6.times do |t|
  Onibus.find_or_create_by(
    numero_onibus: rad.rand(1..9999),
    capacidade_maxima: 40,
    modelo_id: t + 1
  )
end

# =========================
# 9. Rotas exemplo "Paripueira e Maceió"
# =========================
onibus = Onibus.all

municipios_rota = [
  Municipio.find_by(nome: "Maceió"),
  Municipio.find_by(nome: "Paripueira")
]

def hora(h = 0)
  unless h > 8 && h < 20
    return h + 1
  end
  8
end

weekday_rota = Weekday.first
motoristas = Motorista.all

onibus.each_with_index do |bus, idx|
  motorista_choice = motoristas.sample

  rota_ida = Rota.find_or_create_by(
    municipio_origem: municipios_rota[0],
    municipio_destino: municipios_rota[1],
    horario_saida: Time.zone.parse("2025-09-17 #{hora}:00"),
    horario_chegada: Time.zone.parse("2025-09-17 #{hora + 1}:00"),
    weekday: weekday_rota
  )

  rota_volta = Rota.find_or_create_by(
    municipio_origem: municipios_rota[1],
    municipio_destino: municipios_rota[0],
    horario_saida: Time.zone.parse("2025-09-17 #{hora}:00"),
    horario_chegada: Time.zone.parse("2025-09-17 #{hora + 1}:00"),
    weekday: weekday_rota
  )
  if motorista_choice.id == 2
    EscalaOnibus.find_or_create_by(
      onibus: bus,
      motorista: motorista_choice,
      rota: rota_ida
    )

    EscalaOnibus.find_or_create_by(
      onibus: bus,
      motorista: motorista_choice,
      rota: rota_volta
    )
  end
end

# =========================
# Finalização
# =========================
puts "Seed finalizada com sucesso!"
