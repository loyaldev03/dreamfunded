class AddUsersTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :users_type, :text
  end
end
