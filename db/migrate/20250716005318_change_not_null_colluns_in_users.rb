class ChangeNotNullCollunsInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :nome, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :cep, false
  end
end
