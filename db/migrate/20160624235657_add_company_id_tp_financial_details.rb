class AddCompanyIdTpFinancialDetails < ActiveRecord::Migration
  def change
    add_column :financial_details, :company_id, :integer
  end
end
