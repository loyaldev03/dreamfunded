class AddDaysLeftToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :days_left, :integer
  end
end
