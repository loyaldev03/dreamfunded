class ChangeFounderContentType < ActiveRecord::Migration
  def change
    change_column :founders, :content, :text
  end
end
