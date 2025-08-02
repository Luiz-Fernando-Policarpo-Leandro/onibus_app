class CreateModelos < ActiveRecord::Migration[8.0]
  def change
    create_table :modelos do |t|
      t.string :nome
      t.string :fabricante

      t.timestamps
    end
  end
end
