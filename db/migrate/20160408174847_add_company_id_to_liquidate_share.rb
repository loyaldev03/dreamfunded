class AddCompanyIdToLiquidateShare < ActiveRecord::Migration
  def change
    add_column :liquidate_shares, :company_id, :integer
  end
end
