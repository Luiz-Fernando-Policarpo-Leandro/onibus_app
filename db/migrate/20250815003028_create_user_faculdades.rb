class CreateUserFaculdades < ActiveRecord::Migration[8.0]
  def change
    create_table :user_faculdades do |t|
      t.references :user, null: false, foreign_key: true
      t.references :faculdade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
