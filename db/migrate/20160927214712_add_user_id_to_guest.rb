class AddUserIdToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :user_id, :integer
    add_column :guests, :company, :string
  end
end
