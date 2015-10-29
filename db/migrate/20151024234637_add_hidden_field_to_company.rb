class AddHiddenFieldToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :hidden, :boolean, default: false
  end
end
