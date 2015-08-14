class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
    	t.column :title, :string
    	t.column :image_filename, :string
    	t.column :content, :text
    	t.column :source, :string
      	t.timestamps 
    end
  end
end
