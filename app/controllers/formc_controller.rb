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
    params.require(:general_info).permit("name", "kind", "state", "date_formed", "employees_numer", "company_location_address", "company_location_city", "company_location_state", "company_location_zipcode", "website", "employer_id_number")
  end

end
