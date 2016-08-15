class AddEducationToOfficer < ActiveRecord::Migration
  def change
    add_column :officers, :education, :string
  end
end
