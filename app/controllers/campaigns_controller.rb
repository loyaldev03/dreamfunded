class CampaignsController < ApplicationController

  def funding_goal
  end

  def funding_goal_submit
    funding_goal = params[:campaign][:funding_goal].delete('$').delete(',').to_i
    Campaign.create(funding_goal: funding_goal)
    redirect_to campaign_basics_path
  end

  def basics
  end

  def descriptoin
  end

  def legal
  end

  def financial
  end

  def review
  end

end
