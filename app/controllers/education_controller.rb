class EducationController < ApplicationController

  def education
  end

  def investors_basics
    @posts = Post.order(:position).where(page: 'basics')
  end

  def startup_basics
    @posts = Post.order(:position).where(page: 'basics')
  end

  def tips
    @posts = Post.order(:position).where(page: 'tips')
  end

  def investors_terms
    @posts = Post.order(:position).where(page: 'terms')
  end

  def startups_terms
    @posts = Post.order(:position).where(page: 'terms')
  end

  def jobs_act
    @posts = Post.order(:position).where(page: 'jobs_act')
  end

  def fund_raising_guide
    @posts = Post.order(:position).where(page: 'fund_raising_guide')
  end

  def taxes
    @posts = Post.order(:position).where(page: 'taxes')
  end

  def investorqa
    @posts = Post.order(:position).where(page: 'investor-qa')
  end

  def employeeqa
    @posts = Post.order(:position).where(page: 'employee-qa')
  end

  def market_trends
    @posts = Post.order(:position).where(page: 'market_trends')
  end

end
