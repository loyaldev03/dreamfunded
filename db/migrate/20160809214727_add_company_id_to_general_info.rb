class AddCompanyIdToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :company_id, :integer
  end
end
