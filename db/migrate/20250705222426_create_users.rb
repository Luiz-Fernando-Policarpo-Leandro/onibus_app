class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false

      t.string :nome, null: false
      t.string :cpf, null: false
      t.string :cep, null: false

      t.string :matricula, null: false

      t.string :remember_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
