class Onibus < ApplicationRecord
  belongs_to :modelo
  has_many :escala_onibuses
  has_many :rotas, through: :escala_onibuses, dependent: :destroy
end
