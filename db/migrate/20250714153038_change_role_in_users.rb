class ChangeRoleInUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role, :string
    add_reference :users, :role, null: false, foreign_key: true
  end
end
