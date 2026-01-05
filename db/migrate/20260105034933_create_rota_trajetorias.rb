class CreateRotaTrajetorias < ActiveRecord::Migration[8.0]
  def change
    create_table :rota_trajetorias do |t|
      t.references :rota, null: false, foreign_key: true
      t.json :geom

      t.timestamps
    end
  end
end
