class AddCepToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :cep, :string
  end
end
