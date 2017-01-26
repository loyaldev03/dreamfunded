class AddEmploymentToOfficers < ActiveRecord::Migration
  def change
    add_column :officers, :employment, :text
  end
end
