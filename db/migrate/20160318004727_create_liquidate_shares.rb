class CreateLiquidateShares < ActiveRecord::Migration
  def change
    create_table :liquidate_shares do |t|
    	t.string  :name
    	t.string  :company
		t.integer :number_shares
    	t.integer :shares_price
    	t.string  :urgency
    	t.string  :email
    	t.string  :phone
    	t.string  :message
    end
  end
end
