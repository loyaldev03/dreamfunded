class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.string :name
      t.text :info
      t.attachment :image
    end
  end
end
