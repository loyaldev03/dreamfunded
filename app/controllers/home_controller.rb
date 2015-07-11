class HomeController < ApplicationController
	def index
		@Authority = User.Authority
	end

	def team_add

	end

	def add
		if params[:file] != nil
			uploaded_file = params[:file]
			@file_name = uploaded_file.original_filename
			directory = "app/assets/images/"
			path = File.join(directory, @file_name)
			File.open(path, "wb") { |f| f.write(uploaded_file.read)}

			@full_name = param[:full_name]
			@description = param[:description]
			@full_bio = param[:full_bio]
			flash[:file_uploaded] = "Image uploaded"
			profile = Team.new(:full_name => @full_name, :image_name => @file_name, :description => @description, :full_bio => @full_bio)
			profile.save
			redirect_to "/home/team"
		else
			flash[:file_uploaded] = "Image is not valid"
			redirect_to "/home/team_add"
		end
	end

	def about

	end

	def team
		
	end

	def unauthorized

	end
	
end
