class AddValuationToGeneralInfos < ActiveRecord::Migration
  def change
    add_column :general_infos, :valuation, :string
    add_column :general_infos, :burn_rate, :string
    add_column :general_infos, :additional_financing, :boolean
    add_column :general_infos, :additional_sources_capital, :boolean
    add_column :general_infos, :additional_sources_necessary, :boolean

    add_column :general_infos, :has_material_capital, :boolean
    add_column :general_infos, :material_capital, :string
    add_column :general_infos, :material_capital_expenditures, :text

  end
end
