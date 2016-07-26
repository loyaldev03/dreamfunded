class AddAttachmentCapTableToGeneralInfos < ActiveRecord::Migration
  def self.up
    change_table :general_infos do |t|
      t.attachment :cap_table
    end
  end

  def self.down
    remove_attachment :general_infos, :cap_table
  end
end
