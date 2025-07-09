class RenameUsersIdToUserIdInVerifications < ActiveRecord::Migration[8.0]
  def change
    rename_column :verifications, :users_id, :user_id
  end
end
