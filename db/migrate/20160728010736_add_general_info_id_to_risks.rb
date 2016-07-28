class AddGeneralInfoIdToRisks < ActiveRecord::Migration
  def change
    add_column :risks, :general_info_id, :integer
    add_column :fundraise_tiers, :general_info_id, :integer
  end
end
