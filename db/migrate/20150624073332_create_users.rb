class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.column :first_name,:string
    	t.column :last_name,:string
    	t.column :login,:string
    	t.column :email,:string
    	t.column :salt,:stringe
    	t.column :password_digest, :string
    end
  end
end
