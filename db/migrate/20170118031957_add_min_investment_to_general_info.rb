class AddMinInvestmentToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :min_investment, :string
  end
end
