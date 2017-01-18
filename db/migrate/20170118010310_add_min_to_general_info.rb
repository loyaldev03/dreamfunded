class AddMinToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :min_amount, :string
  end
end
