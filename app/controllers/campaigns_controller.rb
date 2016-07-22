class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify

  def funding_goal
    @company = Company.new
  end

  def funding_goal_submit
    funding_goal = params[:campaign][:funding_goal].delete('$').delete(',').to_i
    @company = Company.new(user_id: current_user.id, goal_amount: funding_goal, status: 1)
    if @company.save
      @company.sections << Section.new
      @campaign = Campaign.create(funding_goal: funding_goal, company_id: @company.id)
      FinancialDetail.create(company_id: @company.id)
      redirect_to campaign_basics_path(@campaign.id)
    else
      render :funding_goal
    end
  end

  def funding_goal_exist
    @campaign = Campaign.find(params[:id])
  end

  def funding_goal_update
    funding_goal = params[:campaign][:funding_goal].delete('$').delete(',').to_i
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update(funding_goal: funding_goal)
    redirect_to campaign_basics_path(@campaign.id)
  end

  def basics
    @campaign_id = params[:id]
    @campaign = Campaign.find(params[:id])
    @company = @campaign.company
  end

  def basics_submit
    @campaign = Campaign.find(params[:campaign_id])
    @company = @campaign.company
    @company.update(company_params)
    @campaign.update( tagline: params[:tagline], category: params[:category])
    redirect_to description_path(@campaign.id)
  end

  def description
    @campaign_id = params[:id]
    @campaign = Campaign.find(@campaign_id)
    @company = @campaign.company
  end

  def company_description_submit
    @company = Company.find(params[:company_id])
    youtube_url = youtube_url(params[:video_link])
    @company.update(video_link: youtube_url)
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update(campaign_params)
    redirect_to legal_info_path(@campaign.id)
  end

  def legal_info
    @campaign = Campaign.find(params[:id])
    @company = @campaign.company
  end

  def legal_info_submit
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update(campaign_params)
    redirect_to financial_info_path(@campaign.id)
  end

  def financial_info
    @campaign = Campaign.find(params[:id])
    @financial_details = @campaign.company.financial_detail
  end

  def financial_info_submit
    @campaign = Campaign.find(params[:campaign_id])
    @financial_details = FinancialDetail.find(params[:financial_details])
    @financial_details.update(financial_details_params)
    ContactMailer.campaign_submitted(current_user).deliver
    ContactMailer.check_campaign(@campaign).deliver
    redirect_to "/companies/company_profile/#{@campaign.company.id}"
  end

  def campaign_review
    @campaign = Campaign.find(params[:id])
    @company = @campaign.company
  end

  def edit_campaign
    @campaign = Campaign.find(params[:id])
    @company = @campaign.company
    @members = @company.founders
  end

  def update_campaign
    @campaign = Campaign.find(params[:company][:campaign_attributes][:id])
    @company = @campaign.company
    @company.update(company_params)
    redirect_to :controller => 'companies', :action => 'company_profile', :id => @company.id
  end

  private
  def verify
    if current_user.confirmed == false
      redirect_to url_for(:controller => 'home', :action => 'unverified')
    end
  end

  def company_params
     params.require(:company).permit(:image, :name, :description, :video_link, :user_id, :goal_amount, :website_link,
                     campaign_attributes: [:tagline, :elevator_pitch, :about_campaign, :id, :category, :employees_numer, :company_location_city, :company_location_state],
                     founders_attributes: [:id, :image, :name, :position, :content, :company_id, :created_at, :updated_at, :_destroy],
                     financial_detail_attributes: ["offering_terms", "fin_risks", "income", "totat_income", "total_taxable_income",
                       "total_taxes_paid", "total_assets_this_year", "total_assets_last_year", "cash_this_year", "cash_last_year",
                       "acount_receivable_this_year", "acount_receivable_last_year", "short_term_debt_this_year", "short_term_debt_last_year",
                       "long_term_debt_this_year", "long_term_debt_last_year", "sales_this_year", "sales_last_year", "costs_of_goods_this_year",
                       "costs_of_goods_last_year", "taxes_paid_this_year", "taxes_paid_last_year", "net_income_this_year", "net_income_last_year",
                       "company_id","balance_sheet", "income_statements", "statement_of_cash_flow", "statement_changes_of_equity",
                       "business_plan", "party_transaction", "intended_use_of_proceeds", "capital_structure", "material_terms",
                        "financial_conditions", "directors_background", "accountant_review"]
                     )
  end

  def campaign_params
    params.require(:campaign).permit( "funding_goal", "tagline", "category", "elevator_pitch", "tags", "about_campaign", "employees_numer", "legal_company_name", "employer_id_number", "state_where_incorporated", "office_location", "date_formed", "company_location_address", "company_location_city", "company_location_state", "company_location_zipcode", "company_contact_info_name", "company_contact_info_email", "company_contact_info_phone", "legal_contact_info_name", "legal_contact_info_email", "legal_contact_info_phone", "legal_contact_info_firm", "legal_contact_info_website", "accounting_info_name", "accounting_info_email", "accounting_info_phone", "accounting_info_firm", "accounting_info_website", "state_filing_number","offering_terms",
    "financial_risks", "totat_income", "total_taxable_income", "total_taxes_paid",   )
  end

  def founder_params
    params.require(:founder).permit(:image, :name, :position, :content, :company_id, :created_at, :updated_at)
  end

  def financial_details_params
    params.require(:financial_detail).permit(
      "offering_terms", "fin_risks", "income", "totat_income", "total_taxable_income", "total_taxes_paid", "total_assets_this_year", "total_assets_last_year", "cash_this_year", "cash_last_year", "acount_receivable_this_year", "acount_receivable_last_year", "short_term_debt_this_year", "short_term_debt_last_year", "long_term_debt_this_year", "long_term_debt_last_year", "sales_this_year", "sales_last_year", "costs_of_goods_this_year", "costs_of_goods_last_year", "taxes_paid_this_year", "taxes_paid_last_year", "net_income_this_year", "net_income_last_year", "company_id",
      "balance_sheet", "income_statements", "statement_of_cash_flow", "statement_changes_of_equity", "business_plan", "party_transaction", "intended_use_of_proceeds", "capital_structure", "material_terms", "financial_conditions", "directors_background", "accountant_review"    )
  end

  def youtube_url(url)
    code = url.split("/watch?v=").last
    youtube_url = "https://www.youtube.com/embed/" + code
  end

end
