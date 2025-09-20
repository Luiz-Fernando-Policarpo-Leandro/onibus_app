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

  validate :hour_check
  validate :origem_and_destino_scope_check

  def hour_check
    if horario_saida && horario_chegada && horario_saida >= horario_chegada
      errors.add(:horario_chegada, "deve ser maior que o horário de saída")
    end
  end


  def origem_and_destino_scope_check
    return unless municipio_origem && municipio_destino && weekday && onibuses.any?

    onibuses.each do |bus|
      overlap = Rota.joins(:onibuses)
                    .where(onibuses: { id: bus.id })
                    .where(municipio_origem: municipio_origem, municipio_destino: municipio_destino, weekday: weekday)
                    .where("horario_saida < ? AND horario_chegada > ?", horario_chegada, horario_saida)
                    .where.not(id: id)

      if overlap.exists?
        errors.add(:base, "O ônibus #{bus.numero_onibus} já possui uma rota que conflita com esse horário")
      end
    end
  end
end
