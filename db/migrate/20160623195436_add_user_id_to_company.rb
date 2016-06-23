class AddUserIdToCompany < ActiveRecord::Migration
  def change
    change_column :companies, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
