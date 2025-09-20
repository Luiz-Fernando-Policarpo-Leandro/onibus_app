class Role < ApplicationRecord
  has_many :users
  validates :nome, presence: true, uniqueness: true
end
