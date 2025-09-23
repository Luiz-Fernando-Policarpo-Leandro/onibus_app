class EscalaOnibus < ApplicationRecord
  belongs_to :rota
  belongs_to :onibus

  has_many :motorista_escalas, dependent: :destroy
  has_many :motoristas, through: :motorista_escalas
end
