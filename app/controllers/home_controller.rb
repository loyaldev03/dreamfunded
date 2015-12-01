class HomeController < ApplicationController
	def index
		@Authority = User.Authority
		@news = News.all.reverse
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
			@team = Team.new(team_params)
			if @team.save
				redirect_to "/home/team"
			else
				redirect_to "/home/team_add"
		end
	end

	def about
		@posts = Post.order(:position).where(page: 'about_us')
	end

	def exchange
	end

	def home
		redirect_to "/home"
	end

	def team
		@teams = Team.all.order(:updated_at)
	end

	def fullbio
		@teams = Team.all
		@team_member = Team.friendly.find(params[:id])
	end

	def team_member_edit
		@member = Team.friendly.find(params[:id])
	end

	def team_member_update
		@member = Team.friendly.find(params[:id])

		if @member.update(team_params)
			redirect_to :controller => 'home', :action => 'fullbio', :id => params[:id]
		else
			@error_update = ""
			@member.errors.full_messages.each do |error|
				@error_update = @error_update + error + ". "
			end
			flash[:problem_update] = @error_update
			redirect_to :controller => 'home', :action => 'team_member_edit', :id => params[:id]
		end
	end


	def get_started
		if session[:current_user] == nil || session[:current_user].try(:authority) < 2
			redirect_to "/users/new"
		else
			redirect_to "/companies"
		end
	end

	def unauthorized
	end

	def unverified
	end

	def faq
		@posts = Post.order(:position).where(page: 'faq')
	end

	def legal
	end

	def contact_us
	end

	def contact_us_send_email
		@name = params[:name]
		@email = params[:email]
		@phone = params[:phone]
		@message = params[:message].first
		ContactMailer.contact_us_email(@name, @email, @phone, @message).deliver
		flash[:notice] = 'Thank you'
		redirect_to '/contact'
	end

	def liquidate
	end

	def liquidate_form
		@name = params[:name]
		@email = params[:email]
		@phone = params[:phone]
		@message = params[:message].first
		ContactMailer.liquidate_email(@name, @email, @phone, @message).deliver
		flash[:name] = @name
		redirect_to '/liquidate_after'
	end

	def liquidate_after
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

   def education
   end

   def basics
   	@posts = Post.order(:position).where(page: 'basics')
   end

   def tips
	 end

	 def rules
	 end

	 def terms
	 end

   private
   def team_params
      params.permit(:image, :name, :title, :summary, :fullbio )
   end

end
