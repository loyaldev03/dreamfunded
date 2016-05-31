class CampaignsController < ApplicationController

  def funding_goal
  end

  def funding_goal_submit
    funding_goal = params[:campaign][:funding_goal].delete('$').delete(',').to_i
    @campaign = Campaign.create(funding_goal: funding_goal)
    redirect_to campaign_basics_path(@campaign.id)
  end

  def basics
    @campaign_id = params[:id]
  end

  def basics_submit
    @company = Company.new(company_params)
    @company.save(:validate => false)
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update(company_id: @company.id, tagline: params[:tagline], category: params[:category])
    redirect_to description_path(@campaign.id)
  end

  def description
    @campaign_id = params[:id]
    @campaign = Campaign.find(@campaign_id)
    @company = @campaign.company
  end

  def company_description_submit
    @company = Company.find(params[:company_id])
    @company.update(video_link: params[:video_link])
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update(campaign_params)
    redirect_to legal_info_path(@campaign.id)
  end

  def legal_info
    @campaign = Campaign.find(params[:id])
    @company = @campaign.company
  end

  def legal_info_submit
  end

  def financial
  end

  def review
  end

  private
  def company_params
     params.require(:company).permit(:image, :name, :description, :user_id, :website_link )
  end

  def campaign_params
    params.require(:campaign).permit("funding_goal", "tagline", "category","elevator_pitch", "tags","about_campaign","employees_numer" )
  end

end
