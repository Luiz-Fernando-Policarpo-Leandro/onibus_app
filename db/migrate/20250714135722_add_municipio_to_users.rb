class AddMunicipioToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :municipio, null: false, foreign_key: true
  end
end
