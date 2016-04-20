class AddAccreditedToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :accredited, :boolean
  end
end
