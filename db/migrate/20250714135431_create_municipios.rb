class CreateMunicipios < ActiveRecord::Migration[7.1]
  def change
    create_table :municipios do |t|
      t.string :nome, null: false
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.timestamps
    end
  end
end
