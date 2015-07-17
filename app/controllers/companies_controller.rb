class CompaniesController < ApplicationController
	#Default site that shows all startups
	def index
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
			directory = "app/assets/images/"
			path = File.join(directory, @file_name)
			File.open(path, "wb") { |f| f.write(uploaded_file.read) }
			@user_id = session[:current_user].login
			@name = params[:name]
			@description = params[:description][0]
			flash[:file_upload] = "Image upload was successful"
			uploaded = Company.new(:user_id => @user_id, :name => @name, :description => @description, :image_file_name => @file_name)
			uploaded.save
			redirect_to "/companies"
		else
			flash[:file_uploaded] = "Image is not valid"
			redirect_to "/companies/new"
		end
	end

	def company_profile
		if params[:id] != nil
			@company = Company.find(params[:id])
			render "/companies/company_profile"
		else
			redirect_to "/companies"
		end
	end
end
