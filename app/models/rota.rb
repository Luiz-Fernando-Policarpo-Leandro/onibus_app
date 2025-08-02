class Rota < ApplicationRecord
  belongs_to :municipio_origem, class_name: "Municipio", foreign_key: "municipio_origem_id"
  belongs_to :municipio_destino, class_name: "Municipio", foreign_key: "municipio_destino_id"

  has_many :escala_onibuses

  has_many :onibuses, through: :escala_onibuses
end
