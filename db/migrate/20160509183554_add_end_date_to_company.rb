class AddEndDateToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :end_date, :date
  end
end
