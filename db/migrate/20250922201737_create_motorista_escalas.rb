class CreateMotoristaEscalas < ActiveRecord::Migration[8.0]
  def change
    create_table :motorista_escalas do |t|
      t.references :motorista, null: false, foreign_key: { to_table: :motoristas }
      t.references :escala_onibuses, null: false, foreign_key: true

      t.timestamps
    end
  end
end
