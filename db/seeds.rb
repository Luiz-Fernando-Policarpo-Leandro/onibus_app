# db/seeds.rb

require 'open-uri'
require 'json'

puts "===> Iniciando seed do sistema OnibusApp..."

# =====================================================
# 1. Dias da Semana
# =====================================================
puts "-> Criando dias da semana..."
%w[segunda terca quarta quinta sexta sabado].each do |dia|
  Weekday.find_or_create_by!(name: dia)
end

# =====================================================
# 2. Status
# =====================================================
puts "-> Criando status..."
%w[active block waiting reset_password].each do |status|
  Status.find_or_create_by!(name: status)
end

# =====================================================
# 3. Municípios (IBGE) + Coordenadas
# =====================================================
puts "-> Buscando municípios de AL (IBGE)..."

ibge_url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/27/municipios'
ibge_municipios = JSON.parse(URI.open(ibge_url).read)

COORDENADAS_MUNICIPIOS = {
  "Maceió"     => { lat: -9.6658, lng: -35.7353 },
  "Paripueira" => { lat: -9.4639, lng: -35.5514 },
  "Cajueiro"   => { lat: -9.3986, lng: -36.1550 }
}

puts "-> Criando municípios..."
ibge_municipios.each do |m|
  municipio = Municipio.find_or_create_by!(nome: m["nome"])

  coords = COORDENADAS_MUNICIPIOS[m["nome"]]
  if coords
    municipio.update!(
      latitude: coords[:lat],
      longitude: coords[:lng]
    )
  end
end

# =====================================================
# 4. Faculdades
# =====================================================
puts "-> Criando faculdades..."
Municipio.limit(10).each do |municipio|
  2.times do |i|
    Faculdade.find_or_create_by!(
      nome: "Faculdade #{i + 1} de #{municipio.nome}",
      municipio: municipio
    )
  end
end

# =====================================================
# 5. Roles
# =====================================================
puts "-> Criando roles..."
roles = %w[admin aluno motorista].map do |r|
  Role.find_or_create_by!(nome: r)
end

role_admin     = Role.find_by(nome: "admin")
role_aluno     = Role.find_by(nome: "aluno")
role_motorista = Role.find_by(nome: "motorista")

status_active = Status.find_by(name: "active")

# =====================================================
# 6. Usuários
# =====================================================
puts "-> Criando usuários..."

def cep_por_municipio(nome)
  {
    "Maceió"     => %w[57000000 57035000 57038000],
    "Cajueiro"   => %w[57770000 57771000],
    "Paripueira" => %w[57935000]
  }.fetch(nome, ["57000000"]).sample
end

usuarios = [
  {
    nome: "Gabriel Ramos",
    email: "adm@gmail.com",
    password: "@AdmPassword123",
    cpf: "12345678914",
    role: role_admin,
    municipio: Municipio.find_by(nome: "Maceió")
  },
  {
    nome: "Gilberto",
    email: "motorista@gmail.com",
    password: "@Motorista123",
    cpf: "12345678917",
    role: role_motorista,
    municipio: Municipio.find_by(nome: "Maceió"),
    motorista: {
      cnh: "123456789",
      categoria_cnh: "D",
      validade_cnh: 5.years.from_now
    }
  }
]

usuarios.each do |attrs|
  motorista_attrs = attrs.delete(:motorista)

  user = User.find_or_initialize_by(email: attrs[:email])
  user.assign_attributes(
    nome: attrs[:nome],
    password: attrs[:password],
    cpf: attrs[:cpf],
    role: attrs[:role],
    municipio: attrs[:municipio],
    cep: cep_por_municipio(attrs[:municipio].nome),
    status: status_active
  )
  user.save!

  if motorista_attrs
    user.create_motorista!(motorista_attrs)
  end
end

# =====================================================
# 7. Modelos de Ônibus
# =====================================================
puts "-> Criando modelos de ônibus..."
[
  ["Vision 2000", "Eterna"],
  ["UrbanLink 50", "Cetro"],
  ["Stratos XL", "Horizon"]
].each do |nome, fabricante|
  Modelo.find_or_create_by!(nome: nome, fabricante: fabricante)
end

# =====================================================
# 8. Ônibus
# =====================================================
puts "-> Criando ônibus..."
Modelo.all.each_with_index do |modelo, i|
  Onibus.find_or_create_by!(
    numero_onibus: 1000 + i,
    capacidade_maxima: 40,
    modelo: modelo
  )
end

# =====================================================
# 9. Rotas LÓGICAS (SEM TRAJETÓRIA)
# =====================================================
puts "-> Criando rotas lógicas..."

maceio     = Municipio.find_by(nome: "Maceió")
paripueira = Municipio.find_by(nome: "Paripueira")

weekday = Weekday.find_by(name: "segunda")

Rota.find_or_create_by!(
  municipio_origem: maceio,
  municipio_destino: paripueira,
  horario_saida: Time.zone.parse("08:00"),
  horario_chegada: Time.zone.parse("09:30"),
  weekday: weekday
)

Rota.find_or_create_by!(
  municipio_origem: paripueira,
  municipio_destino: maceio,
  horario_saida: Time.zone.parse("17:00"),
  horario_chegada: Time.zone.parse("18:30"),
  weekday: weekday
)

puts "===> Seed finalizada com sucesso."
