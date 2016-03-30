class BidsController < ApplicationController

	#Default site that shows all startups
	def index
		@companies = Company.all
	end

    def bid_params
      params.require(:bid).permit()
    end

    def bid
    	@company = Company.find(params[:id])
   	end

    def new
		@bid = Bid.new
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
	end

	def edit

	end

	def update

	end

	def show 
		@company = Company.find(params[:id])
		@auctions = LiquidateShare.where(company: @company.name)
	end



end

