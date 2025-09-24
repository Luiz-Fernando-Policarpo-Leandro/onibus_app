class Rota < ApplicationRecord
  belongs_to :municipio_origem, class_name: "Municipio", foreign_key: "municipio_origem_id"
  belongs_to :municipio_destino, class_name: "Municipio", foreign_key: "municipio_destino_id"
  belongs_to :weekday

  has_many :escala_onibuses
  has_many :onibuses, through: :escala_onibuses
  has_many :motoristas, through: :escala_onibuses

  validates :weekday, presence: true
  validates :municipio_origem, :municipio_destino, presence: true
  validates :horario_saida, :horario_chegada, presence: true


  validate :hour_check
  validate :origem_and_destino_scope_check

  private

  def hour_check
    if horario_saida >= horario_chegada
      errors.add(:horario_chegada, "deve ser maior que o horário de saída")
    end
  end

  def origem_and_destino_scope_check
    return unless onibuses.any?

    onibus_ids = onibuses.pluck(:id)

    conflict = Rota.joins(:onibuses)
                 .where(onibuses: { id: onibus_ids })
                 .where(weekday: weekday)
                 .where("horario_saida < ? AND horario_chegada > ?", horario_chegada, horario_saida)
                 .where.not(id: id)
                 .exists?

    if conflict
      errors.add(:base, "Já existe uma rota nesse intervalo de horário para um dos ônibus selecionados")
    end
  end
end
