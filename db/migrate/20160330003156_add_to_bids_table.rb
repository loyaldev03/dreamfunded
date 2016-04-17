class AddToBidsTable < ActiveRecord::Migration
  def change
  	  	add_column :bids, :auction_id, :string
  	    add_column :bids, :user_id, :string
  	    add_column :bids, :seller_id, :string
  	    add_column :bids, :bid_amount, :string
  	    add_column :bids, :counter_amount, :string
  	    add_column :bids, :accepted, :boolean
  end
end
