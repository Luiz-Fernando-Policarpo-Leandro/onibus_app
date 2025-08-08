require 'open-uri'  # Para requisições HTTP
require 'json'      # Para parsear JSON


# Criar status base
%w[active block waiting].each do |status_name|
  Status.find_or_create_by(name: status_name)
end

# Busca e cria municípios de Alagoas
url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/27/municipios'

puts("Create Municipios")
data = URI.open(url).read
municipios = JSON.parse(data)


municipios.each do |m|
  nome = m['nome']
  Municipio.find_or_create_by(nome: nome)
end


# CEPs ficticios por município
CEPS_POR_MUNICIPIO = {
  "Maceió" => [ "57000000", "57035000", "57038000", "57040000" ],
  "Arapiraca" => [ "57300000", "57302020", "57310005" ],
  "Cajueiro" => [ "57770000", "57771000" ],
  "Penedo" => [ "57200000", "57202000" ],
  "Delmiro Gouveia" => [ "57480000" ]
}

# Criar roles aluno e adm
puts("create users")
%w[admin aluno].each do |role_name|
  Role.find_or_create_by(nome: role_name)
end

# Função que retorna CEP aleatório
def cep_aleatorio(municipio)
  CEPS_POR_MUNICIPIO.fetch(municipio, [ "57000-000" ]).sample
end

# Criar admins
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
    telefones: [ "82912345678", "82987654321" ]
  },
  {
    nome: "Mario Penedo",
    email: "user_adm_master2@gmail.com",
    password: "@AdmPassword123",
    cpf: "12345678910",
    cep: cep_aleatorio("Cajueiro"),
    role_id: Role.find_by(nome: "admin").id,
    municipio_id: Municipio.find_by(nome: "Cajueiro").id,
    matricula: "123456789",
    telefones: [ "82911223344" ]
  }
]

# telfones ficcionais
users_adm.each do |adm_attrs|
  telefones = adm_attrs.delete(:telefones)
  user = User.find_or_initialize_by(email: adm_attrs[:email])
  user.assign_attributes(adm_attrs.merge(status_id: Status.find_by(name: "active").id))
  user.save!

  telefones.each do |num|
    Phone.find_or_create_by(user_id: user.id, number: num)
  end
end

## modelos de onibus
modelos_onibus = { "vision 2000": "Eterna Indústrias",
  "AetherGlide": "Vanguard Motors",
  "Stratos XL": "Horizon Transports",
  "UrbanLink 50": "Cetro Veículos",
  "Trilha Master": "Nômade Veículos"
}

modelos_onibus.each do |nome, fabricante|
  Modelo.find_or_create_by!(nome: nome, fabricante: fabricante)
end

puts "Seed finalizada."
