class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.text :description
      t.date :date
      t.string :link

      t.timestamps
    end
  end
end
