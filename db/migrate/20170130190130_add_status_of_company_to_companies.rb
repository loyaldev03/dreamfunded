class AddStatusOfCompanyToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :status_of_company, :string
  end
end
