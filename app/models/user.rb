class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create # Validações para a senha

  has_one :verification
  belongs_to :status
  belongs_to :role
  belongs_to :municipio

  validates :role, presence: true
end
