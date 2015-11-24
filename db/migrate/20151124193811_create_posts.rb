class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.text :title
      t.string :source
      t.attachment :image

      t.timestamps
    end
  end
end
