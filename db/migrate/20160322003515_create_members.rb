class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.text :summary
      t.text :fullbio
      t.string :title
      t.integer :rank

      t.timestamps
    end
  end
end
