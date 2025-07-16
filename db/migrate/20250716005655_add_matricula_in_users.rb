class AddMatriculaInUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :matricula, :string, default: "", null: false
    add_column :users, :cpf, :string, null: false
  end
end
