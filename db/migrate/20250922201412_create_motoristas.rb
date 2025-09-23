class CreateMotoristas < ActiveRecord::Migration[8.0]
  def change
    create_table :motoristas do |t|
      t.references :user, null: false, foreign_key: true
      t.string :cnh
      t.string :categoria_cnh
      t.date :validade_cnh

      t.timestamps
    end
  end
end
