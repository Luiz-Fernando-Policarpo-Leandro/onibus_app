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
%w[admin aluno].each do |role_name|
  Role.find_or_create_by(nome: role_name)
end

# =========================
# 6. Usuários Admin
# =========================
puts "-> Criando usuários admin..."
users_adm = [
  {
    nome: "Gabriel Ramos",
    email: "user_adm_master1@gmail.com",
    password: "@AdmPassword123",
    cep: cep_aleatorio("Maceió"),
    cpf: "12345678914",
    role_id: Role.find_by(nome: "admin").id,
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
    role_id: Role.find_by(nome: "admin").id,
    municipio_id: Municipio.find_by(nome: "Cajueiro").id,
    matricula: "123456789",
    telefones: %w[82911223344]
  }
]

faculdades = Faculdade.order("RAND()").limit(users_adm.length)

users_adm.each_with_index do |adm_attrs, idx|
  telefones = adm_attrs.delete(:telefones)

  user = User.find_or_initialize_by(email: adm_attrs[:email])
  user.assign_attributes(adm_attrs.merge(status_id: Status.find_by(name: "active").id))
  user.save!

  # Associa faculdade
  user.faculdades << faculdades[idx] if faculdades[idx].present?

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
# Finalização
# =========================
puts "Seed finalizada com sucesso!"
