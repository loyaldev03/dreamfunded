class AddCompanyIdToInvestmentForFundamericas < ActiveRecord::Migration
  def change
    add_column :investment_for_fundamericas, :issuer_id, :string
  end
end
