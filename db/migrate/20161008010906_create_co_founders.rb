class CreateCoFounders < ActiveRecord::Migration
  def change
    create_table :co_founders do |t|
      t.string :name
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
