class FormcController < ApplicationController
  before_action :authenticate_user!

  def general
    @general_info = GeneralInfo.new
  end

  def general_save
    info = GeneralInfo.create(general_info_params)
    redirect_to action: :people, id: info.id
  end

  def people
    @general_info = GeneralInfo.find(params[:id])
    @securities = [Security.new(security_class: 'Common Stock'), Security.new(security_class: 'Debt Securities')]
    @securities_reserver = [Security.new(security_class: 'Warrants'), Security.new(security_class: 'Options')]
  end

  def people_save
    @general_info = GeneralInfo.find(params[:id])
    @general_info.update(general_info_params)
    redirect_to action: :terms, id: @general_info.id
  end

  def terms
    @general_info = GeneralInfo.find(params[:id])
    @perks = [InvestmentPerk.new(amount: 250), InvestmentPerk.new(amount: 500),InvestmentPerk.new(amount: 1000), InvestmentPerk.new(amount: 5000)]
    @term = Term.new
  end

  def terms_save
    @general_info = GeneralInfo.find(params[:id])
    @general_info.update(general_info_params)
    redirect_to action: :disclosures, id: @general_info.id
  end

  def disclosures
    @general_info = GeneralInfo.find(params[:id])
    @risk = Risk.new
    @tier = FundraiseTier.new(amount: 20000)
  end

  def disclosure_save
    @general_info = GeneralInfo.find(params[:id])
    @general_info.update(general_info_params)
    redirect_to action: :financials, id: @general_info.id
  end

  def financials
    @general_info = GeneralInfo.find(params[:id])
  end

  def submit
  end

private
  def general_info_params
    params.require(:general_info).permit("name", "cap_table", "kind", "state", "date_formed", "employees_numer", "company_location_address", "company_location_city", "company_location_state", "company_location_zipcode", "website", "employer_id_number",
        securities_attributes: [:security_class,  :_destroy, :amount, :outstanding, :voting_rights, :other_rights, :general_info_id, :securities_reserved, :created_at, :updated_at],
        principal_holders_attributes: [:name, :securities_held, :_destroy, :voting_power, :general_info_id, :created_at, :updated_at],
        officers_attributes: [ "name", "email", "year_joined", "_destroy", "officers", "director", "position", "occupation", "main_employer", "general_info_id", "created_at", "updated_at"],
        investment_perks_attributes: [:content, :amount,:_destroy],
        terms_attributes: [
          "safe_cap", "valuation_cap", "_destroy", "investor_threshold", "pro_rata?", "governing_law_state", "days", "raised_this_round", "discount", "store_credit", "store_discount", "general_info_id"
        ],
        fundraise_tiers_attributes: [:id, :content, :amount, :_destroy],
        risks_attributes: [:id, :content, :_destroy]

      )
  end

end
