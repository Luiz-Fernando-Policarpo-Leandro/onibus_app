class AddMotoristaToEscalaOnibuses < ActiveRecord::Migration[8.0]
  def change
    add_reference :escala_onibuses, :motorista, null: false, foreign_key: { to_table: :motoristas }
  end
end
