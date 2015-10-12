class AddTextsToNews < ActiveRecord::Migration
  def change
    change_column :news, :content, :text
    change_column :news, :source, :text
    change_column :news, :title, :text
  end
end
