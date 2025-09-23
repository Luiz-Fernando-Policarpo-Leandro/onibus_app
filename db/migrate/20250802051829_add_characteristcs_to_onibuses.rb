class AddCharacteristcsToOnibuses < ActiveRecord::Migration[8.0]
  def change
    add_column :onibuses, :terminal_origem, :string
    add_column :onibuses, :numero_onibus, :integer
    add_column :onibuses, :capacidade_maxima, :integer
    add_reference :onibuses, :modelo, null: false, foreign_key: true
  end
end
