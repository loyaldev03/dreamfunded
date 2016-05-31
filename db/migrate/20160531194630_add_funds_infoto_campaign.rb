class AddFundsInfotoCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :offering_terms, :text
    add_column :campaigns, :financial_risks, :text
    add_column :campaigns, :totat_income, :integer
    add_column :campaigns, :total_taxable_income, :integer
    add_column :campaigns, :total_taxes_paid, :integer
  end
end
