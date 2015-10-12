class AddDocuSignLink < ActiveRecord::Migration
  def change
    add_column :companies, :docusign_url, :text
  end
end
