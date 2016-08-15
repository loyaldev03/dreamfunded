class AddGenerailInfoIdToFinancialDetail < ActiveRecord::Migration
  def change
    add_column :financial_details, :general_info_id, :integer
  end
end
