class AddFundAmericaIdToInvestments < ActiveRecord::Migration
  def change
    add_column :investments, :fund_america_id, :string
  end
end
