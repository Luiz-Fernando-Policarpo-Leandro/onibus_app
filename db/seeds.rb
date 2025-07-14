require 'open-uri' # Para utilizar a API do IBGE
require 'json'

# Criar status base
status_base = [ "active", "block", "waiting" ]
status_base.each do |status_name|
  Status.find_or_create_by(name: status_name)
end

# Busca e cria municípios de Alagoas
url = url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/27/municipios'

data = URI.open(url).read
municipios = JSON.parse(data)

municipios.each do |m|
  nome = m['nome']
  Municipio.find_or_create_by(nome: nome)
end

# CEPs por município
CEPS_POR_MUNICIPIO = {
  "Maceió" => [ "57000-000", "57035-000", "57038-000", "57040-000" ],
  "Arapiraca" => [ "57300-000", "57302-020", "57310-005" ],
  "Cajueiro" => [ "57770-000", "57771-000" ],
  "Penedo" => [ "57200-000", "57202-000" ],
  "Delmiro Gouveia" => [ "57480-000" ]
}

# Criar roles aluno e adm
[ "admin", "aluno" ].each do |role_name|
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
    role_id: Role.find_by(nome: "admin").id,
    municipio_id: Municipio.find_by(nome: "Maceió").id
  },
  {
    nome: "Mario Penedo",
    email: "user_adm_master2@gmail.com",
    password: "@AdmPassword123",
    cep: cep_aleatorio("Cajueiro"),
    role_id: Role.find_by(nome: "admin").id,
    municipio_id: Municipio.find_by(nome: "Cajueiro").id
  }
]

users_adm.each do |adm|
  user = User.find_or_initialize_by(email: adm[:email])
  user.assign_attributes(
    nome: adm[:nome],
    password: adm[:password],
    cep: adm[:cep],
    role_id: adm[:role_id],
    municipio_id: adm[:municipio_id],
    status: Status.find_by(name: "active")
  )
  user.save!
end

puts "Seed finalizada."
