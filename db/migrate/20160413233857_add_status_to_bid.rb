class AddStatusToBid < ActiveRecord::Migration
  def change
    add_column :bids, :status, :string
  end
end
