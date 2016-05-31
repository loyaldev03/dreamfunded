class AddLegalInfotoCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :legal_company_name, :string
    add_column :campaigns, :employer_id_number, :string
    add_column :campaigns, :state_where_incorporated, :string
    add_column :campaigns, :office_location, :string
    add_column :campaigns, :date_formed, :date

    add_column :campaigns, :company_location_address, :string
    add_column :campaigns, :company_location_city, :string
    add_column :campaigns, :company_location_state, :string
    add_column :campaigns, :company_location_zipcode, :string

    add_column :campaigns, :company_contact_info_name, :string
    add_column :campaigns, :company_contact_info_email, :string
    add_column :campaigns, :company_contact_info_phone, :string

    add_column :campaigns, :legal_contact_info_name, :string
    add_column :campaigns, :legal_contact_info_email, :string
    add_column :campaigns, :legal_contact_info_phone, :string
    add_column :campaigns, :legal_contact_info_firm, :string
    add_column :campaigns, :legal_contact_info_website, :string

    add_column :campaigns, :accounting_info_name, :string
    add_column :campaigns, :accounting_info_email, :string
    add_column :campaigns, :accounting_info_phone, :string
    add_column :campaigns, :accounting_info_firm, :string
    add_column :campaigns, :accounting_info_website, :string

    add_column :campaigns, :state_filing_number, :string


  end
end
