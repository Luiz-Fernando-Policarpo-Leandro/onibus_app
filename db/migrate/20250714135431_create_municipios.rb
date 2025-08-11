class CreateMunicipios < ActiveRecord::Migration[7.1]
  def change
    create_table :municipios do |t|
      t.string :nome, null: false
      t.timestamps
    end
  end
end
