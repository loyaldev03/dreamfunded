class CompaniesController < ApplicationController
	#Default site that shows all startups
	def index
		@companies = Companies.all
	end
	
	def new

	end

	#Creates a new startup profile (Need to implement session for later)
	def create
		if params[:file] != nil && session[:current_user] != nil
			uploaded_file = params[:file]
			@file_name = uploaded_file.original_filename
			directory = "app/assets/images/"
			path = File.join(directory, @file_name)
			File.open(path, "wb") { |f| f.write(uploaded_file.read) }
			@user_id = session[:current_user]
			@name = params[:name]
			@description = params[:description][0]
			flash[:file_upload] = "Image upload was successful"
			uploaded = Companies.new(:user_id => @user_id, :name => @name, :description => @description, :image_file_name => @file_name)
			uploaded.save
			redirect_to "/companies"
		else
			flash[:file_uploaded] = "Image is not valid or you are not logged in"
			redirect_to "/companies/new"
		end
	end
end
