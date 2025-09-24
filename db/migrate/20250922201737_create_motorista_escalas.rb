class CreateMotoristaEscalas < ActiveRecord::Migration[8.0]
  def change
    create_table :motorista_escalas do |t|
      t.references :motorista, null: false, foreign_key: { to_table: :motoristas }
      t.references :escala_onibus, null: false, foreign_key: { to_table: :escala_onibuses }

      t.timestamps
    end
  end
end
