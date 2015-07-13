class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
    	t.column :title, :string
    	t.column :image_filename, :string
    	t.column :content, :string
      	t.timestamps #uh how does this work.
    end
  end
end
