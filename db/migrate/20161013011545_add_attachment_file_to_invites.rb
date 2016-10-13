class AddAttachmentFileToInvites < ActiveRecord::Migration
  def self.up
    change_table :invites do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :invites, :file
  end
end
