class CreateFinancialDetails < ActiveRecord::Migration
  def change
    create_table :financial_details do |t|
      t.column :offering_terms,:text
      t.column :fin_risks,:text
      t.column :income,:text
      t.column :totat_income, :integer
      t.column :total_taxable_income, :integer
      t.column :total_taxes_paid, :integer

      t.column  :total_assets_this_year, :integer
      t.column  :total_assets_last_year, :integer

      t.column  :total_assets_this_year, :integer
      t.column  :total_assets_last_year, :integer

      t.column  :cash_this_year, :integer
      t.column  :cash_last_year, :integer

      t.column  :acount_receivable_this_year, :integer
      t.column  :acount_receivable_last_year, :integer

      t.column  :short_term_debt_this_year, :integer
      t.column  :short_term_debt_last_year, :integer

      t.column  :long_term_debt_this_year, :integer
      t.column  :long_term_debt_last_year, :integer

      t.column  :sales_this_year, :integer
      t.column  :sales_last_year, :integer

      t.column  :costs_of_goods_this_year, :integer
      t.column  :costs_of_goods_last_year, :integer

      t.column  :taxes_paid_this_year, :integer
      t.column  :taxes_paid_last_year, :integer

      t.column  :net_income_this_year, :integer
      t.column  :net_income_last_year, :integer
    end
  end
end
