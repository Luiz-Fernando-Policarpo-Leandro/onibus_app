class Municipio < ApplicationRecord
  has_many :users
  has_many :alunos, through: :users
  has_many :faculdades
end
