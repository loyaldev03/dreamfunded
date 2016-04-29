class CreatePressPost < ActiveRecord::Migration
  def change
    create_table :press_posts do |t|
      t.datetime :date
      t.text :name
      t.string :source
      t.text :url
    end
  end
end
