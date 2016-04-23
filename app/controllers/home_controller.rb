class HomeController < ApplicationController
	invisible_captcha only: [:liquidate_form, :contact_us_send_email, :get_funded_send]

	def index
		@Authority = User.Authority
		@news = News.all.reverse
		if @news.size > 2
			@news_one = @news.first
			@news_two = @news.second
			@news_three = @news.third
		end
	end


	def sellers
		@sellers = LiquidateShare.all
	end

	def edit_seller
		@seller = LiquidateShare.find(params[:id])
	end

	def new_seller
		@seller = LiquidateShare.new
	end

	def create_new_seller
		LiquidateShare.create(liquidate_share_params)
		redirect_to sellers_path
	end

	def edit_liq_seller
		@seller = LiquidateShare.find_by(id: params[:liquidate_share][:id])
		@seller.update(liquidate_share_params)
		redirect_to sellers_path
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

	def link_team
		redirect_to "/team"
	end

	def unauthorized
	end

	def unverified
	end

	def faq
		@posts = Post.order(:position).where(page: 'faq')
	end

	def howItWorks
		@posts = Post.order(:position).where(page: 'how_works')
	end

	def legal
	end

	def contact_us
	end

	def portfolio
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
		@first_name = params[:first_name]
		@last_name = params[:last_name]
		@email = params[:email]
		@phone = params[:phone]
		@company_id = params[:company_id]
		@number_shares = params[:number_shares].delete(',').to_i
		@shares_price = params[:shares_price]
		@timeframe = params[:timeframe]
		@rofr_restrictions = params[:rofr_restrictions]
		@financial_assistance = params[:financial_assistance]
		@message = params[:message].first
		ContactMailer.liquidate_email(@first_name, @last_name, @company, @number_shares, @shares_price, @timeframe, @email, @phone, @rofr_restrictions, @financial_assistance, @message).deliver
		password = SecureRandom.hex(3)
		seller = User.create(first_name: @first_name, last_name: @last_name, email: @email, password: password, password_confirmation: password, role: 'seller', confirmed: true, authority: 1)
		LiquidateShare.create(first_name: @first_name, last_name: @last_name, company_id: @company_id, number_shares: @number_shares, shares_price: @shares_price, timeframe: @timeframe, email: @email, phone: @phone, rofr_restrictions: @rofr_restrictions, financial_assistance: @financial_assistance, message: @message, user_id: seller.id)
		ContactMailer.seller_account(seller, password).deliver
		flash[:name] = @first_name
		redirect_to '/liquidate_after'
	end

	def email_all_investors
		seller = LiquidateShare.find(params[:id])
		seller.update(approved: true)
		first_name = seller.first_name
		last_name = seller.last_name
		email = seller.email
		phone = seller.phone
		company = seller.company
		number_shares = seller.number_shares
		shares_price = seller.shares_price
		ContactMailer.open_auction_email(first_name, last_name, email, phone, company, number_shares, shares_price).deliver
		redirect_to '/sellers'
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
   	@posts = Post.order(:position).where(page: 'tips')
	 end

	 def rules
	 end

	 def terms
	 	@posts = Post.order(:position).where(page: 'terms')
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

	 def get_funded
	 end

	def get_funded_send
		company = params[:company]
		email = params[:email]
		entrepreneur_last = params[:entrepreneur_last]
		entrepreneur_first = params[:entrepreneur_first]
		country = params[:country]
		phone = params[:phone]
		address = params[:address]
		website = params[:website]
		city = params[:city]
		state = params[:state]
		zipcode = params[:zipcode]
		timeframe = params[:timeframe]
		month_created = params[:date][:month]
		year_created = params[:date][:year]
		number_employees = params[:number_employees]
		two_line_summary = params[:two_line_summary].first
		business_summary = params[:business_summary].first
		market_of_customers = params[:market_of_customers].first
		customer_problem = params[:customer_problem].first
		current_customers = params[:current_customers].first
		solution =  params[:solution].first
		market_strategy = params[:market_strategy].first
		business_modal = params[:business_modal].first
		competitors = params[:competitors].first
		qualifications = params[:qualifications].first
		barriers = params[:barriers].first
		executive_summary_file = params[:executive_summary_file]
 		investor_slide_file = params[:investor_slide_file]
		round_name = params[:round_name]
		burn_rate = params[:burn_rate]
		previous_capital = params[:previous_capital]
		current_revenue = params[:current_revenue]
		amout_seeking = params[:amout_seeking]
		esimated_valuation = params[:esimated_valuation]
		exit_strategy = params[:exit_strategy].first

		ContactMailer.get_funded(company, email, entrepreneur_last,entrepreneur_first, country, phone, address, website, city, state, zipcode, timeframe, month_created, year_created, number_employees, two_line_summary, business_summary, market_of_customers, customer_problem, current_customers, solution, market_strategy, business_modal, competitors, qualifications, barriers, executive_summary_file,  investor_slide_file, round_name, burn_rate, previous_capital, current_revenue, amout_seeking, esimated_valuation, exit_strategy).deliver
		redirect_to :get_funded_after
	end

	def get_funded_after

	end

   private
   def team_params
      params.require(:team).permit(:image, :name, :title, :summary, :fullbio )
   end

   def liquidate_share_params
   	params.require(:liquidate_share).permit(:first_name, :last_name, :email,  :phone, :company, :number_shares, :shares_price, :timeframe, :rofr_restrictions, :financial_assistance, :message)
   end
end
