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
  end

  def company_description_submit

    redirect_to legal_info_path
  end

  def legal_info
  end

  def financial
  end

  def review
  end

  private
  def company_params
     params.require(:company).permit(:image, :name, :description, :user_id, :website_link )
  end

end
