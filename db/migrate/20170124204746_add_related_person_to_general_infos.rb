class AddRelatedPersonToGeneralInfos < ActiveRecord::Migration
  def change
    add_column :general_infos, :transaction, :text
    add_column :general_infos, :related_person, :text
    add_column :general_infos, :conflicts, :text
  end
end
