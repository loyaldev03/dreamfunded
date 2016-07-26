class FormcController < ApplicationController
  before_action :authenticate_user!

  def general
    @general_info = GeneralInfo.new
  end

  def general_save
    GeneralInfo.create(general_info_params)
    redirect_to action: :people
  end

  def people
    @company = Company.last
    @general_info = GeneralInfo.last
    @securities = [Security.new(security_class: 'Common Stock'), Security.new(security_class: 'Debt Securities')]
    @securities_reserver = [Security.new(security_class: 'Warrants'), Security.new(security_class: 'Options')]
  end

  def people_save

    redirect_to action: :terms
  end

  def terms
  end

  def disclosures
  end

  def financials
  end

  def submit
  end

private
  def general_info_params
    params.require(:general_info).permit("name", "kind", "state", "date_formed", "employees_numer", "company_location_address", "company_location_city", "company_location_state", "company_location_zipcode", "website", "employer_id_number",
        securities_attributes: [:security_class,  :amount, :outstanding, :voting_rights, :other_rights, :general_info_id, :securities_reserved, :created_at, :updated_at],
        principal_holders_attributes: [:name, :securities_held, :voting_power, :general_info_id, :created_at, :updated_at],
        officers_attributes: [ "name", "email", "year_joined", "officers", "director", "position", "occupation", "main_employer", "general_info_id", "created_at", "updated_at"]
      )
  end

end
