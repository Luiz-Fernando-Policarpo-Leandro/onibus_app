class Motorista < ApplicationRecord
  self.table_name = "motoristas"
  belongs_to :user

  has_many :motorista_escalas, dependent: :destroy
  has_many :escalas, through: :motorista_escalas, source: :escala_onibus
  has_many :rotas, through: :escalas


  validates :user_id, presence: true, uniqueness: true
  validates :cnh, presence: true
  validates :categoria_cnh, presence: true
  validates :validade_cnh, presence: true

  validate :validate_cnh_date

  private

  def validate_cnh_date
    errors.add(:validade_cnh, "já venceu") if validade_cnh < Date.today
  end
end
