class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.column :user_id,:integer
      t.column :email,  :string
      t.column :token,  :string
      t.timestamps
    end
  end
end
