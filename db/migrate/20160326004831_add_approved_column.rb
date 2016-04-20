class AddApprovedColumn < ActiveRecord::Migration
  def change
  	 add_column :liquidate_shares, :approved, :boolean
  end
end
