class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :municipio
  belongs_to :faculdade


  validates :horario_saida, presence: true
  validates :horario_chegada, presence: true

  # validate hour
  validate :comparation_hour

  private

  def comparation_hour
    return if horario_saida.blank? || horario_volta.blank?

    # transforma em minutos
    inicio = horario_saida.hour * 60 + horario_saida.min
    fim = horario_volta.hour * 60 + horario_volta.min

    if fim < inicio + 40
      errors.add(:horario_volta, "deve ser pelo menos 40 minutos depois do horário de saída")
    end
  end
end
