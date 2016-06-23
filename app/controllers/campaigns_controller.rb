class CampaignsController < ApplicationController

  def funding_goal
    if session[:current_user] == nil
      redirect_to url_for(:controller => 'users', :action => 'login')
    end
  end

  def funding_goal_submit
    funding_goal = params[:campaign][:funding_goal].delete('$').delete(',').to_i
    @company = Company.new(user_id: user_session.id, goal_amount: funding_goal, status: 1)
    @company.save(:validate => false)
    @campaign = Campaign.create(funding_goal: funding_goal, company_id: @company.id)
    redirect_to campaign_basics_path(@campaign.id)
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
  end

  def financial_info_submit
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update(campaign_params)
    ContactMailer.campaign_submitted(user_session).deliver
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
  end

  def update_campaign
    @campaign = Campaign.find(params[:company][:campaign_attributes][:id])
    @company = @campaign.company
    @company.update(company_params)

    redirect_to :controller => 'companies', :action => 'company_profile', :id => @company.id
  end

  private
  def company_params
     params.require(:company).permit(:image, :name, :description, :user_id, :goal_amount, :website_link, campaign_attributes: [:elevator_pitch, :about_campaign] )
  end

  def campaign_params
    params.require(:campaign).permit( "funding_goal", "tagline", "category", "elevator_pitch", "tags", "about_campaign", "employees_numer", "legal_company_name", "employer_id_number", "state_where_incorporated", "office_location", "date_formed", "company_location_address", "company_location_city", "company_location_state", "company_location_zipcode", "company_contact_info_name", "company_contact_info_email", "company_contact_info_phone", "legal_contact_info_name", "legal_contact_info_email", "legal_contact_info_phone", "legal_contact_info_firm", "legal_contact_info_website", "accounting_info_name", "accounting_info_email", "accounting_info_phone", "accounting_info_firm", "accounting_info_website", "state_filing_number","offering_terms",
    "financial_risks", "totat_income", "total_taxable_income", "total_taxes_paid",   )
  end

  def youtube_url(url)
    code = url.split("/watch?v=").last
    youtube_url = "https://www.youtube.com/embed/" + code
  end

end
