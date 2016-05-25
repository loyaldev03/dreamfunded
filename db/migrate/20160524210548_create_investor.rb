class CreateInvestor < ActiveRecord::Migration
  def change
    create_table :investors do |t|
      t.integer :annual_income
      t.integer :new_worth
      t.boolean :us_citizen
      t.boolean :exempt_withholding
      t.string :ssn
    end
  end
end
