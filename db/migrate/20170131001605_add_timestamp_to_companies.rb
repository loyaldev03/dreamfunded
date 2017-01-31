class AddTimestampToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :timestamp, :datetime
  end
end
