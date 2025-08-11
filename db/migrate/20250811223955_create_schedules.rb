class CreateSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.time :horario_saida, null: false
      t.time :horario_volta, null: false
      t.references :municipio, null: false, foreign_key: true
      t.references :faculdade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
