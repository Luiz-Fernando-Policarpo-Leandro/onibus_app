class User < ApplicationRecord
  has_secure_password

  belongs_to :status
  belongs_to :role
  belongs_to :municipio
  has_one :verification

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  validates :cpf, presence: true, uniqueness: true
  validates :cep, presence: true
  validates :matricula, presence: true
end
