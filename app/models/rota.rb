class Rota < ApplicationRecord
  belongs_to :municipio_origem, class_name: "Municipio", foreign_key: "municipio_origem_id"
  belongs_to :municipio_destino, class_name: "Municipio", foreign_key: "municipio_destino_id"
  belongs_to :weekday

  has_many :escala_onibuses
  has_many :onibuses, through: :escala_onibuses


  validates :weekday, presence: true
  validates :municipio_origem, presence: true
  validates :municipio_destino, presence: true
  validates :horario_saida, presence: true
  validates :horario_chegada, presence: true

end
