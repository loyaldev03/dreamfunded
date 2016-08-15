class CreateInvestmentPerks < ActiveRecord::Migration
  def change
    create_table :investment_perks do |t|
      t.text :content
      t.string :amount
      t.integer :general_info_id
      t.timestamps
    end
  end
end
