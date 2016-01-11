class UsersController < ApplicationController
	def index
		@users = User.all()
	end

	def login
	end

	def new
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
		@users = User.all.order(:first_name)
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
		@first_name = params[:first_name]
		@last_name = params[:last_name]
		@password = params[:password]
		@email = params[:email]
		@phone = params[:phone]

		#Change to enum / class later
		if params[:reg] == nil
			@authority = User.Authority[:Accredited]
		else
			@authority = User.Authority[:Basic]
		end

		record = User.new(:first_name => @first_name, :last_name => @last_name, :email => @email, :authority => @authority, phone: @phone)
		record.password = @password
		record.password_confirmation = params[:password_confirmation]
		if record.valid?
			record.save
			ContactMailer.verify_email(record).deliver
			ContactMailer.account_created(record).deliver
			flash[:notice] = "Registration successful."
			redirect_to(:action => :post_login, :email => @email, :password => @password)
		else
			flash[:notice] = "Validation failed."
			@error_message = ""
			record.errors.full_messages.each do |error|
				@error_message = @error_message + error + ". "
			end
			render(:action => :new)
		end
	end

	def post_login
		login_user = User.find_by(email: params[:email])
		if login_user == nil
			flash[:notice] = "This user ID does not exist."
			redirect_to(:action => :login)
		else
			password = params[:password]

			if(login_user.password_valid?(password))
				session[:current_user] = login_user
				redirect_to url_for(:controller => 'home', :action => 'index')
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
		#ContactMailer.welcome_email(user).deliver
		ContactMailer.personal_hello(user).deliver
		redirect_to root_path
	end

end
