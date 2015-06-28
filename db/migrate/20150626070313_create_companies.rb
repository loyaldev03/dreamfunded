class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.column :user_id,:string
    	t.column :name,:string
    	t.column :description,:string
    	t.column :image_file_name, :string
    	t.column :invested_amount, :integer
    end
  end
end
