class AddProductDescrGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :maket_strategy, :text
    add_column :general_infos, :company_description, :text
  end
end
