class CreateRota < ActiveRecord::Migration[8.0]
  def change
    create_table :rota do |t|
      t.references :municipio_origem, null: false, foreign_key: { to_table: :municipios }
      t.references :municipio_destino, null: false, foreign_key: { to_table: :municipios }
      t.time :horario_saida
      t.time :horario_chegada
      t.string :dias_da_semana
      t.timestamps
    end
  end
end
