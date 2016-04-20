class AddTimestamps < ActiveRecord::Migration
  def change
  	add_column :liquidate_shares, :created_at, :datetime
  	add_column :liquidate_shares, :updated_at, :datetime
  end
end
