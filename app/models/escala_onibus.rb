class EscalaOnibus < ApplicationRecord
  belongs_to :rota
  belongs_to :onibus
  belongs_to :motorista
end
