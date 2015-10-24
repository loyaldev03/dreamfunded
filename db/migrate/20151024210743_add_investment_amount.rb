class AddInvestmentAmount < ActiveRecord::Migration
  def change
    add_column :investments, :invested_amount, :integer, default: 0
  end
end
