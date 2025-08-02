class CreateEscalaOnibuses < ActiveRecord::Migration[8.0]
  def change
    create_table :escala_onibuses do |t|
      t.references :onibus, null: false, foreign_key: true
      t.references :rota, null: false, foreign_key: true

      t.timestamps
    end
  end
end
