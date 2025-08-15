class Faculdade < ApplicationRecord
  belongs_to :municipio

  has_many :user_faculdade, dependent: :destroy
  has_many :users, through: :user_faculdade
end
