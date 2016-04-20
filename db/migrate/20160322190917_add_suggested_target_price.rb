class AddSuggestedTargetPrice < ActiveRecord::Migration
  def change
  	  	add_column :liquidate_shares, :suggested_target_price, :float
  end
end
