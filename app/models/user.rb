class User < ApplicationRecord
  has_secure_password


  belongs_to :status
  belongs_to :role
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
  validates :password, presence: true, length: { minimum: 8 }, on: :create

  validates :cpf, presence: true, uniqueness: true
  validates :cep, presence: true
  validates :matricula, presence: true


  def admin?
    self.role.present? && self.role.nome == "admin"
  end

  # session autentication
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  # save token
  def remember
    self.remember_token = User.new_token
    update_column(:remember_digest, User.digest(remember_token)) # update in database
  end

  # check if the token is on the database
  def authenticated?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  # erase in db
  def forget
    update_column(:remember_digest, nil)
  end

  attr_accessor :remember_token
end
