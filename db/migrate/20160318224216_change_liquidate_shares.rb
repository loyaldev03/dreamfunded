class ChangeLiquidateShares < ActiveRecord::Migration
  def change
  	change_column :liquidate_shares, :message, :text
  end
end
