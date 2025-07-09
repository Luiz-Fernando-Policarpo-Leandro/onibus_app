class CreateVerifications < ActiveRecord::Migration[8.0]
  def change
    create_table :verifications do |t|
      t.string :code_verification
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
