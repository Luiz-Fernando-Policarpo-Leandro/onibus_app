class Onibus < ApplicationRecord
  belongs_to :modelo
  has_many :escala_onibuses

  validates :numero_onibus, presence: true
  validates :capacidade_maxima, presence: true

  has_many :rotas, through: :escala_onibuses, dependent: :destroy
  accepts_nested_attributes_for :rotas, allow_destroy: true
end
