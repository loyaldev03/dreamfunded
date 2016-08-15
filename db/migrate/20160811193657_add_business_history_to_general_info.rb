class AddBusinessHistoryToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :business_history, :text
    add_column :general_infos, :product_description, :text
    add_column :general_infos, :competition, :text
    add_column :general_infos, :customer_base, :text
    add_column :general_infos, :intellectual_property, :text
    add_column :general_infos, :governmental_regulatory, :text
    add_column :general_infos, :litigation, :text
    add_column :general_infos, :phone, :text


  end
end
