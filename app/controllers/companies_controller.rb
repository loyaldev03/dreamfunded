class CompaniesController < ApplicationController
	before_action :verify

	def index
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Basic]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@companies = Company.all.order(:position).where(hidden: false, accredited: true)
	end

	def nonaccredited_index
		@companies = Company.all.order(:position).where(hidden: false, accredited: false)
	end

	def auctions
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Basic]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@companies = Company.all.order(:position).where(hidden: false)
	end

	def new
		@company = Company.new
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
	end

	#Creates a new startup profile (Need to implement session for later)
	def create
		# if params[:file] != nil
			# uploaded_file = params[:file]
			# @file_name = uploaded_file.original_filename
			# directory = "app/assets/images/companies/"
			# path = File.join(directory, @file_name)
			# File.open(path, "wb") { |f| f.write(uploaded_file.read) }

			# @user_id = session[:current_user].login
			# @name = params[:name]
			# @description = params[:description][0]
			# @goal = params[:goal]
			# @status = params[:status]
			# @invested = 0
			# @weblink = ""
			# @videolink = ""
			# @ceo = params[:CEO]
			# @number = params[:CEO_number]
			# @display = 0
			# image = params[:image]

			# if params[:amount]
			# 	@invested = params[:amount]
			# end

			# if params[:url]
			# 	@weblink = params[:url]
			# end

			# if params[:video]
			# 	@videolink = params[:video]
			# end
			@company = Company.new(company_params)
			# uploaded = Company.new(:user_id => @user_id, :name => @name, :description => @description,
			# 	:goal_amount => @goal, :status => @status, :invested_amount => @invested, :website_link => @weblink, :video_link => @videolink,
			# 	:CEO => @ceo, :CEO_number => @number, :display => @display, :days_left => 10, )

			if @company.save
				section = Section.new
				@company.sections << section
				redirect_to "/companies"
			else
				@error_message = ""
				@company.errors.full_messages.each do |error|
					@error_message = @error_message + error + ". "
				end
				flash[:message] = @error_message
				redirect_to "/companies/new"
			end
		# else
		# 	flash[:message] = "Image is not valid"
		# 	redirect_to "/companies/new"
		# end
	end

	def edit
		@companies = Company.all
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
	end

	def action
		@my_company = Company.find_by(id: params[:id])

		if @my_company == nil
			@message = ""
			@message = "No company with that ID exists. Please create the company first."
			flash[:fail] = @message
			redirect_to url_for(:controller => 'companies', :action => 'edit')
		elsif params[:id] != nil && params[:desired_action] == "1"
			redirect_to url_for(:controller => 'companies', :action => 'make_team', :id => params[:id])

		elsif params[:id] != nil && params[:desired_action] == "2"
			redirect_to url_for(:controller => 'companies', :action => 'make_profile', :id => params[:id])
		end
	end

	def make_team
		@founder = Founder.new
		@companies = Company.all
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
	end

	def add_team_member
		# @id = params[:id]
		# if params[:file1] != nil
		# 	uploaded_file = params[:file1]

		# 	@file_name = uploaded_file.original_filename

		# 	directory = "app/assets/images/companies/"
		# 	path = File.join(directory, @file_name)

		# 	File.open(path, "wb") { |f| f.write(uploaded_file.read) }

		# 	@name = params[:name1]
		# 	@content = params[:content1][0]
		# 	@position = params[:position]
		# 	@comp_id = params[:id]
		# 	founder1 = Founder.new(:name => @name, :position => @position, :image_address => @file_name, :content => @content, :company_id => @comp_id)

		# 	if founder1.valid?
		# 		founder1.save
		# 		redirect_to "/companies"
		# 	else
		# 		@error_message2 = ""
		# 		founder1.errors.full_messages.each do |error|
		# 			@error_message2 = @error_message2 + error + ". "
		# 		end

		# 		flash[:notice] = @error_message2
			@founder = Founder.new(founder_params)
			if @founder.save
				redirect_to "/companies"
			else
				flash[:notice] = "Image is not valid"
				redirect_to "/companies/make_team"
			end
	end

	def make_profile
		@company = Company.find(params[:id])
		@companies = Company.all
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Founder]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
	end

	def submit_profile
		@company = Company.find(params[:id])
		@section = @company.sections.first

		@overview = params[:overview][0]
		@tm = params[:target_market][0]
		@cid = params[:current_investor_details][0]
		@dm = params[:detailed_metrics][0]
		@ct = params[:customer_testimonials][0]
		@cl = params[:competitive_landscape][0]
		@use = params[:planned_use_of_funds][0]
		@pitch = params[:pitch_deck][0]

		if @section.update(:overview => @overview, :target_market => @tm, :current_investor_details => @cid, :detailed_metrics => @dm, :customer_testimonials => @ct, :competitive_landscape => @cl, :planned_use_of_funds => @use, :pitch_deck => @pitch)
			redirect_to "/companies"
		else
			@error_message3 = ""
			section.errors.full_messages.each do |error|
				@error_message3 = @error_message3 + error + ". "
			end
			flash[:problem] = @error_message3
			redirect_to "/companies/make_profile"
		end
	end

	def company_profile
		if params[:id] != nil
			@id = params[:id]
			@company = Company.find(params[:id])
			@progress = @company.invested_amount / @company.goal_amount rescue 0

			@members = @company.founders
			@section = @company.sections.first

			@bid = Bid.find_by(user_id: user_session.id, company_id: @id)
			@bid = Bid.new if @bid == nil
		else
			redirect_to "/companies"
		end
	end

	def edit_profile
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Admin]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@company = Company.find(params[:id])
	end

	def update
		@company = Company.find(params[:id])
		if @company.update(company_params)
			redirect_to :controller => 'companies', :action => 'company_profile', :id => params[:id]
		else
			@error_update = ""
			@company.errors.full_messages.each do |error|
				@error_update = @error_update + error + ". "
			end
			flash[:problem_update] = @error_update
			redirect_to :controller => 'companies', :action => 'edit_profile', :id => params[:id]
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

    def remove_founder
		if params[:id] != nil
	    	@founder = Founder.find(params[:id])
	    	if @founder!= nil
	    		@founder.destroy
	    	end
	    end

	    redirect_to "/companies"
    end

    def approve_company
		if params[:id] != nil
	    	@company = Company.find(params[:id])
	    	if @company != nil
	    		@company.update_column :display, 1
	    	end
	    end

    	redirect_to "/companies"
    end

    def epay
    	if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Basic]
				redirect_to url_for(:controller => 'home', :action => 'unauthorized')
			end
    end

    def thank_you

    end

    def submit_bid
    	user = session[:current_user]
    	investment = ProspectiveInvestment.create(user_id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email, phone: user.phone, shares_price: params[:shares_price], investment_amount: params[:investment_amount], company: params[:name], company_id: params[:id])
			ContactMailer.prospective_investment_email(user.first_name, user.last_name, user.email, user.phone, investment.company, investment.investment_amount, investment.shares_price)
			redirect_to '/companies'
   	end

   private
   def verify
   	user = User.find(session[:current_user])
   	if user.confirmed == false
   		redirect_to url_for(:controller => 'home', :action => 'unverified')
   	end
   end

   def section_params
   	params.require(:section).permit(:company_id, :overview, :target_market, :current_investor_details, :detailed_metrics, :customer_testimonials, :competitive_landscape, :planned_use_of_funds, :pitch_deck, :created_at, :updated_at)
   end

   def company_params
      params.require(:company).permit(:image, :document, :hidden, :position, :docusign_url, :user_id, :name, :description, :image, :invested_amount, :website_link, :video_link, :goal_amount, :status, :CEO, :CEO_number, :display, :days_left, :created_at, :updated_at, :suggested_target_price)
   end

   def founder_params
   	params.require(:founder).permit(:image, :name, :position, :content, :company_id, :created_at, :updated_at)
   end
end
