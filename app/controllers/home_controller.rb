class HomeController < ApplicationController
	def index
		@Authority = User.Authority
		@news = New.all.reverse
		if @news.size > 2
			@news_one = @news.first
			@news_two = @news.second
			@news_three = @news.third
		end
	end

	def team_add
		@team = Team.new
	end

	def create
		#if params[:image] != nil
			# uploaded_file = params[:file]
			# @file_name = uploaded_file.original_filename
			# directory = "app/assets/images/team"
			# path = File.join(directory, @file_name)
			# File.open(path, "wb") { |f| f.write(uploaded_file.read) }
			# flash[:file_upload] = "Image upload was successful"

			# @name = params[:name]
			# @summary = params[:summary][0]
			# @fullbio = params[:fullbio][0]
			@team = Team.new(team_params)
			if @team.save
				redirect_to "/home/team"
			#uploaded = Team.new(:name => @name, :file_name => @file_name, :summary => @summary, :fullbio=>@fullbio)
			#uploaded.save
			else
			#flash[:file_uploaded] = "Image is not valid"
				redirect_to "/home/team_add"
		end
	end

	def about

	end

	def home
		redirect_to "/home"
	end

	def team
		@teams = Team.all
	end

	def fullbio
		@teams = Team.all
		@id = params[:id]
		@team = Team.find(@id)
	end


	def get_started
		if session[:current_user] == nil
			redirect_to "/users/new"
		else
			redirect_to "/companies"
		end
	end

	def unauthorized

	end

	def remove_team
    if params[:id] != nil
      @team = Team.find(params[:id])
      if (@team != nil)
        @team.destroy
      end
    end
    redirect_to "/home/team"
   end
   private
   def team_params
      params.require(:team).permit(:image, :name, :image, :summary, :fullbio )
   end

end
