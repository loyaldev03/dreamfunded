class UsersController < ApplicationController
	invisible_captcha only: [:create]
	def index
		@users = User.all()
	end

	def login
	end

	def new
		@user = User.new
	end

	def show
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		user = User.find_by(id: params[:id])
		Investment.create(user_id: user.id, company_id: params[:company_id], invested_amount: params[:user][:invested_amount])
		redirect_to(:action => :write)
	end

	def portfolio
		if session[:current_user] == nil
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		user = User.find(session[:current_user].id)
		@investments = user.investments
	end

	def portfolio_admin
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Admin]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@user = User.find(params[:id])
		@investments = @user.investments
	end

	def remove_investment
		investment = Investment.find(params[:id])
		investment.destroy
		redirect_to url_for(:action => 'write')
	end

	def write
		if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Admin]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@current_user = session[:current_user]
		@Authority = User.Authority
		@users = User.all.order(:created_at)
		@new = News.new
	end

	# Controller for profile page
	def profile
		if session[:current_user] == nil
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@current_user = session[:current_user]
	end

	#Promotes a user
	def promote
		user_login = params[:user]
		@user = User.find_by(email: user_login)
		if @user.authority != 4
			@user.update_column(:authority, @user.authority+1)
		end
		redirect_to(:action => :write)
	end

	#Demotes a user
	def demote
		user_login = params[:user]
		@user = User.find_by(email: user_login)
		if @user.authority != 1
			@user.update_column(:authority, @user.authority-1)
		end
		redirect_to(:action => :write)
	end

	#Delete a user
	def delete
		user_login = params[:user]
		@user = User.find_by(email: user_login)
		@user.destroy
		redirect_to(:action => :write)
	end

	def create
		#@login = params[:login]
		@first_name = params[:user][:first_name]
		@last_name = params[:user][:last_name]
		@password = params[:user][:password]
		@password_confirmation = params[:user][:password_confirmation]
		@email = params[:user][:email]
		@phone = params[:user][:phone]
		@token = params[:user][:token]

		if @token
			invite = Invite.find_by(token: @token)
			invite.update(email: @email)
			invite.use_token
		end
		role = params[:user_role]

		#Change to enum / class later
		if params[:reg] == nil
			@authority = User.Authority[:Accredited]
		else
			@authority = User.Authority[:Basic]
		end

		@user = User.new(:first_name => @first_name, :last_name => @last_name, :email => @email, :authority => @authority, phone: @phone, role: role, password: @password, password_confirmation: @password_confirmation)

		#@user.password_confirmation = params[:user][:password_confirmation]
		if @user.valid?
			@user.save
			@user.investor = Investor.create
			ContactMailer.verify_email(@user).deliver
			ContactMailer.account_created(@user).deliver
			ContactMailer.unaccredited_investor(@user).deliver if @user.authority == 1

			if @user.first_name && @user.last_name && @user.email && Rails.env.production?
				Infusionsoft.contact_add({:FirstName => @user.first_name , :LastName => @user.last_name, :Email => @user.email})
			end
			session[:current_user] = @user
			redirect_to(:controller => 'home', :action => 'index')
		else
			flash[:signup_errors] = "Validation failed."
			@error_message = ""
			@user.errors.full_messages.each do |error|
				@error_message = @error_message + error + ". "
			end
			render(:action => :new)
		end

	end

	def post_login
		login_user = User.find_by(email: params[:email], provider: nil)
		if login_user == nil
			flash[:notice] = "This user ID does not exist."
			redirect_to(:action => :login)
		else
			password = params[:password]
			if(login_user.password_valid?(password))
				session[:current_user] = login_user
				if login_user.authority >= 2
					redirect_to url_for(:controller => 'companies', :action => 'index')
				else
					redirect_to url_for(:controller => 'home', :action => 'index')
				end
			else
				flash[:notice] = "Wrong password. Please try again."
				redirect_to(:action => :login)
			end
		end
	end

	# Signs out and redirects to the homepage
	def signout
		session[:current_user] = nil
		redirect_to :controller => 'home'
	end

	def change_password
	end

	def post_change_password
		user = User.find_by(email: params[:email])
		if user
			ContactMailer.reset_email(user).deliver
			ContactMailer.reset_password_request(user).deliver
			flash[:notice] = "You will receive an email with instructions on how to reset your password."
			redirect_to(:action => :login)
		else
			flash[:notice] = "Email not found"
			redirect_to(:action => :change_password)
		end
	end

	def new_password
		@user = User.find_by(email: params[:reset_password_email])
	end

	def reset_password
		@user = User.find_by(email: params[:email])
		password = params[:password]
		password_confirmation = params[:password_confirmation]
		if @user.update(password: password, password_confirmation: password_confirmation)
			session[:current_user] = @user
			redirect_to url_for(:controller => 'home', :action => 'index')
		else
			@error_message = ""
			@user.errors.full_messages.each do |error|
				@error_message = @error_message + error + ". "
			end
			render :new_password, locals: {user: @user}
		end
	end

	def verify
		user = User.find_by(email: params[:email])
		user.confirmed = true
		user.save(:validate => false)
		session[:current_user] = user
		#ContactMailer.welcome_email(user).deliver
		ContactMailer.personal_hello(user).deliver
		redirect_to root_path
	end

	def certify
	end

	def certify_user
		user = User.find(params[:id])
		if params[:reg] == nil
			@authority = User.Authority[:Accredited]
		else
			@authority = User.Authority[:Basic]
		end
		user.update(authority: @authority)
		if user.first_name && user.last_name && user.email && Rails.env.production?
			Infusionsoft.contact_add({:FirstName => user.first_name , :LastName => user.last_name, :Email => user.email})
		end
		ContactMailer.personal_hello(user).deliver
		ContactMailer.account_created(user).deliver
		session[:current_user] = user
		redirect_to root_path
	end


	def admin
		@users = User.all.where(authority: 1)
	end

	def companies
		@companies = Company.all.where(accredited: false)
	end

	def campaign
		if user_session.companies.any?
			id = user_session.companies.first.id
			redirect_to(:controller => 'companies', :action => :company_profile, id: id)
		else
			redirect_to funding_goal_path
		end
	end

end
