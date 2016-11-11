class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :bio, :text
  end
end
