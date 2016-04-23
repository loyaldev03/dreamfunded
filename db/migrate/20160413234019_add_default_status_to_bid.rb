class AddDefaultStatusToBid < ActiveRecord::Migration
  def change
    change_column :bids, :status, :string, :default => 'pending'
  end
end
