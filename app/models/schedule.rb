class Schedule < ApplicationRecord
  belongs_to :users
  belongs_to :municipio
  belongs_to :faculdade
end
