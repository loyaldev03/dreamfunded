class AddMinInvestmentToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :min_investment, :integer, default: 100
  end
end
