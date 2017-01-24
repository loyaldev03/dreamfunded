class AddNewFieldsToGeneralInfos < ActiveRecord::Migration
  def change
    add_column :general_infos, :rds, :string
    add_column :general_infos, :rds_years, :string
    add_column :general_infos, :upcoming_rd, :string
    add_column :general_infos, :real_estate, :text
  end
end
