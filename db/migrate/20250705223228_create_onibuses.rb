class CreateOnibuses < ActiveRecord::Migration[8.0]
  def change
    create_table :onibuses do |t|
      t.timestamps
    end
  end
end
