class ChangBidCounterDefault < ActiveRecord::Migration
  def change
    change_column :bids, :counter_amount, :integer, :default => 0
  end
end
