class AddDiscountGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :discount, :string
  end
end
