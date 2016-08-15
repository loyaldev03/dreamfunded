class AddMonthlySustainAmount < ActiveRecord::Migration
  def change
    add_column :financial_details, :sustain_amount, :decimal
  end
end
