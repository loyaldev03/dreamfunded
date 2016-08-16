class AddCompletedToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :completed, :boolean, default: false
  end
end
