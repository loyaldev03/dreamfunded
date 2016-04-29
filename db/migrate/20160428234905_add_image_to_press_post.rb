class AddImageToPressPost < ActiveRecord::Migration
  def change
    add_column :press_posts, :quote, :text
    add_attachment :press_posts, :image
  end
end
