class AddStatusToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :status, null: false, foreign_key: true
  end
end
