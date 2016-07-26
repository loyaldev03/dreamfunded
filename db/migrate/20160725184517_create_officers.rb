class CreateOfficers < ActiveRecord::Migration
  def change
    create_table :officers do |t|
      t.string :name
      t.string :email
      t.string :year_joined
      t.boolean :officers
      t.boolean :director
      t.text :position
      t.text :occupation
      t.string :main_employer
      t.integer :general_info_id

      t.timestamps
    end
  end
end
