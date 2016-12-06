class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.attachment :image
      t.attachment :background

      t.timestamps
    end
  end
end
