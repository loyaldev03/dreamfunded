class AddAttachmentDocumentToCompanies < ActiveRecord::Migration
  def self.up
    change_table :companies do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :companies, :document
  end
end
