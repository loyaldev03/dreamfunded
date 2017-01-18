class AddNumberSharesToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :number_of_securities, :string
    add_column :general_infos, :price_of_securities, :string
  end
end
