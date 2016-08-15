class AddDaysToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :days, :integer
  end
end
