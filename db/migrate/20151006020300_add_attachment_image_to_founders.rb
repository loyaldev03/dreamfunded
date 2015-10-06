class AddAttachmentImageToFounders < ActiveRecord::Migration
  def self.up
    change_table :founders do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :founders, :image
  end
end
