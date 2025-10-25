class CreateFaculdades < ActiveRecord::Migration[8.0]
  def change
    create_table :faculdades do |t|
      t.string :nome, null: false
      t.references :municipio, null: false, foreign_key: true
      t.timestamps
    end
  end
end
