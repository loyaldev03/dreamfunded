class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integet :user_id
      t.integet :parent_id
      t.integet :company_id
      t.timestamps
    end
  end
end
