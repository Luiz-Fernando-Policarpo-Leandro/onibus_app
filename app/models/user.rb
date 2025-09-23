class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password

  belongs_to :status

  belongs_to :role
  has_one :motorista, dependent: :destroy

  belongs_to :municipio

  has_one :verification

  has_many :user_faculdade, dependent: :destroy
  has_many :faculdades, through: :user_faculdade

  has_many :schedules, dependent: :destroy
  accepts_nested_attributes_for :schedules, allow_destroy: true

  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, on: [ :create, :update ]
  validate :password_complexity

  validates :cpf, presence: true, uniqueness: true
  validates :cep, presence: true
  validates :matricula, presence: true



  def admin?
    self.role.present? && self.role.nome == "admin"
  end

  private

  def password_complexity
    return if password.blank?

    unless password =~ /[a-z]/ && password =~ /[A-Z]/ && password =~ /\d/ && password =~ /[^A-Za-z0-9]/
      errors.add :password, "deve conter pelo menos uma letra maiúscula, uma letra minúscula, um número e um caractere especial"
    end
  end
end
