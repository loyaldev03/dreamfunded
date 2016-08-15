class CreateGeneralInfos < ActiveRecord::Migration
  def change
    create_table :general_infos do |t|
      t.column :name, :string
      t.column :kind, :string
      t.column :state, :string
      t.column :date_formed, :date
      t.column :employees_numer, :integer

      t.column :company_location_address, :text
      t.column :company_location_address, :string
      t.column :company_location_state, :string
      t.column :company_location_zipcode, :string

      t.column :website, :string
      t.column :employer_id_number, :string
      t.timestamps
    end
  end
end
