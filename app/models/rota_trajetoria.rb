class RotaTrajetoria < ApplicationRecord
  belongs_to :rota

  validates :geom, presence: true
end
