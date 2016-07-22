class AddCityToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :company_location_city, :string
  end
end
