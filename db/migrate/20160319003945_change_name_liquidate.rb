class ChangeNameLiquidate < ActiveRecord::Migration
  def change
  	rename_column :liquidate_shares, :name, :first_name
  	add_column :liquidate_shares, :last_name, :string
  end
end
