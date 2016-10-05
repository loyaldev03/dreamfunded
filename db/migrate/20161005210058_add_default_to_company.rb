class AddDefaultToCompany < ActiveRecord::Migration
  def change
    change_column :companies, :invested_amount, :integer, default: 0
  end
end
