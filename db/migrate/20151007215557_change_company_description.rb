class ChangeCompanyDescription < ActiveRecord::Migration
  def change
    change_column :companies, :description, :text
  end
end
