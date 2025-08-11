class User < ApplicationRecord
  has_secure_password

  belongs_to :status
  belongs_to :role
  belongs_to :municipio
  has_one :verification

  has_many :schedules, dependent: :destroy
  accepts_nested_attributes_for :schedules, allow_destroy: true

  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }, on: :create

  validates :cpf, presence: true, uniqueness: true
  validates :cep, presence: true
  validates :matricula, presence: true

  validates :faculdade, presence: true


  def admin?
    self.role.present? && self.role.nome == "admin"
  end
end
