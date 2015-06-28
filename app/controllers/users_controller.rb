class UsersController < ApplicationController
	def index
		@users = User.all()
	end

	def login

	end 

	def new

	end

	def create
		@login = params[:login]
		@first_name = params[:first_name]
		@last_name = params[:last_name]
		@password = params[:password]
		@email = params[:email]
		record = User.new(:login=> @login, :first_name => @first_name, :last_name => @last_name, :email => @email)
		record.password = @password
		record.password_confirmation = params[:password_confirmation]
		if record.valid?
			record.save
			flash[:notice] = "Registration successful"
			redirect_to(:action => :login)
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
		login_user = User.find_by(login: params[:username])
		if login_user == nil
			flash[:notice] = "This user ID does not exist" 
			redirect_to(:action => :login)
		else
			password = params[:password]
			
			if(login_user.password_valid?(password))
				session[:current_user] = login_user.login 
				redirect_to url_for(:controller => 'home', :action => 'index')
			else
				flash[:notice] = "Wrong password. Please try again"
				redirect_to(:action => :login)
			end
		end
	end

	def log_out
		session[:current_user] = nil
		redirect_to(:action => :login)
	end
end
