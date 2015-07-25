class CompaniesController < ApplicationController
	#Default site that shows all startups
	def index
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Basic]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@companies = Company.all
	end
	
	def new
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
	end

	#Creates a new startup profile (Need to implement session for later)
	def create
		if params[:file] != nil
			uploaded_file = params[:file]
			@file_name = uploaded_file.original_filename
			directory = "app/assets/images/companies/"
			path = File.join(directory, @file_name)
			File.open(path, "wb") { |f| f.write(uploaded_file.read) }

			@user_id = session[:current_user].login
			@name = params[:name]
			@description = params[:description][0]
			@goal = params[:goal]
			@status = params[:status]
			@invested = 0
			@weblink = ""
			@videolink = ""
			@ceo = params[:CEO]
			@number = params[:CEO_number]

			if params[:amount]
				@invested = params[:amount]
			end

			if params[:url]
				@weblink = params[:url]
			end

			if params[:video]
				@videolink = params[:video]
			end

			uploaded = Company.new(:user_id => @user_id, :name => @name, :description => @description, :image_file_name => @file_name,
				:goal_amount => @goal, :status => @status, :invested_amount => @invested, :website_link => @weblink, :video_link => @videolink, 
				:CEO => @ceo, :CEO_number => @number)
			
			if uploaded.valid?
				uploaded.save
				redirect_to "/companies"
			else
				@error_message = ""
				uploaded.errors.full_messages.each do |error|
					@error_message = @error_message + error + ". "
				end
				flash[:message] = @error_message
				redirect_to "/companies/new"
			end
		else
			flash[:message] = "Image is not valid"
			redirect_to "/companies/new"
		end
	end

	def company_profile
		if params[:id] != nil
			@company = Company.find(params[:id])
			@progress = @company.invested_amount / @company.goal_amount rescue 0

			render "/companies/company_profile"
		else
			redirect_to "/companies"
		end
	end

	def remove_company
		if params[:id] != nil
	    	@company = Company.find(params[:id])
	    	if (@company != nil) 
	    		@company.destroy
	    	end
	    end
    	
    	redirect_to "/companies"
    end
end
