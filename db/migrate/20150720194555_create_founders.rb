class CreateFounders < ActiveRecord::Migration
  def change
    create_table :founders do |t|
      t.string :name
      t.string :image_address
      t.text :content

      t.timestamps
    end
  end
end
