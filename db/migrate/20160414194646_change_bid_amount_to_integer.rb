class ChangeBidAmountToInteger < ActiveRecord::Migration
  def change
    remove_column :bids, :bid_amount
    remove_column :bids, :counter_amount
    add_column :bids, :bid_amount, :float
    add_column :bids, :counter_amount, :float
  end
end
