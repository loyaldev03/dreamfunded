class CreateInvestmentForFundamericas < ActiveRecord::Migration
  def change
    create_table :investment_for_fundamericas do |t|
      t.references :user, index: true
      t.string :investor_id
      t.string :subscription_agreement_id
      t.string :investment_id

      t.timestamps
    end
  end
end
