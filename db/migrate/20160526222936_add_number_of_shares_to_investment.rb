class AddNumberOfSharesToInvestment < ActiveRecord::Migration
  def change
    add_column :investments, :number_of_shares, :integer
  end
end
