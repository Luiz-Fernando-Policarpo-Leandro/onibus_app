class Municipio < ApplicationRecord
  has_many :users
  has_many :alunos, through: :users
end
