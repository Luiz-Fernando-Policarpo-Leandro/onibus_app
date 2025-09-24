class Motorista < ApplicationRecord
  self.table_name = "motoristas"
  belongs_to :user

  has_many :escala_onibuses, dependent: :destroy
  has_many :rotas, through: :escala_onibuses

  validates :user_id, presence: true, uniqueness: true
  validates :cnh, :categoria_cnh, :validade_cnh, presence: true


  validate :validate_cnh_date

  private

  def validate_cnh_date
    errors.add(:validade_cnh, "já venceu") if validade_cnh < Date.today
  end
end
