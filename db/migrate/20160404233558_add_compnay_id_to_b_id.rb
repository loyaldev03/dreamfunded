class AddCompnayIdToBId < ActiveRecord::Migration
  def change
    add_column :bids, :company_id, :integer
    add_column :bids, :number_of_shares, :integer
  end
end
