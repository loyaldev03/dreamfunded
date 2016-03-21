class AddColLiquidate4 < ActiveRecord::Migration
  def change
  	rename_column :liquidate_shares, :urgency, :timeframe
  	add_column :liquidate_shares, :rofr_restrictions, :boolean
  	add_column :liquidate_shares, :financial_assistance, :boolean
  end
end
