class AddBusinessPlanToGeneralInfo < ActiveRecord::Migration
  def change
    add_column :general_infos, :business_model, :text
    add_column :general_infos, :business_plan, :text
  end
end
