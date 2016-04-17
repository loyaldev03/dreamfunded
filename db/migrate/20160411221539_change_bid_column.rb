class ChangeBidColumn < ActiveRecord::Migration
  def change
    remove_column :bids, :user_id
    remove_column :bids, :seller_id
    add_column :bids, :user_id, :integer
  end
end
