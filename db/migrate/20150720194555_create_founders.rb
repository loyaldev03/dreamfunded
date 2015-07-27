class CreateFounders < ActiveRecord::Migration
  def change
    create_table :founders do |t|
      t.column :name, :string
      t.column :position, :string
      t.column :image_address, :string
      t.column :content, :string

      t.column :company_id, :integer

      t.timestamps
    end
  end
end
