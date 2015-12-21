class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.column :email,:string
      t.column :newsletter_type, :string
      t.timestamps
    end
  end
end
