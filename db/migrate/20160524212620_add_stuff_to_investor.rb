class AddStuffToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :country, :string
    add_column :investors, :date_of_birth, :date
    add_column :investors, :address, :text
    add_column :investors, :city, :string
    add_column :investors, :state, :string
    add_column :investors, :zipcode, :string
    add_column :investors, :user_id, :integer
    add_column :investors, :drive_license, :string
    add_attachment :investors, :image
  end
end
