class AddUserIdToLiquidateShare < ActiveRecord::Migration
  def change
    add_column :liquidate_shares, :user_id, :integer
  end
end
