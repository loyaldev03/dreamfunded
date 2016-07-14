class UsersController < ApplicationController
	invisible_captcha only: [:create]
	before_action :authenticate_user!, only: [:portfolio]


	def edit
		@user = User.find(params[:id])
	end

	def update
		user = User.find_by(id: params[:id])
		Investment.create(user_id: user.id, company_id: params[:company_id], invested_amount: params[:user][:invested_amount])
		redirect_to(:action => :write)
	end

	def portfolio
		@investments = current_user.investments
	end

	def verify
		user = User.find_by(email: params[:email].delete(' '))
		user.confirmed = true
		user.save(:validate => false)
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
		redirect_to root_path
	end

	def campaign
		if current_user.companies.any?
			id = current_user.companies.last.id
			redirect_to(:controller => 'companies', :action => :company_profile, id: id)
		else
			redirect_to funding_goal_path
		end
	end

	#move to admin
	def portfolio_admin
		if current_user == nil || current_user.authority < User.Authority[:Admin]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@user = User.find(params[:id])
		@investments = @user.investments
	end
	#move to admin
	def remove_investment
		investment = Investment.find(params[:id])
		investment.destroy
		redirect_to url_for(:action => 'write')
	end
  #move to admin
	def write
		if current_user == nil || current_user.authority < User.Authority[:Admin]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
		@current_user = current_user
		@Authority = User.Authority
		@users = User.all.order(:created_at)
		@new = News.new
	end
	#move to Admin COntroller
	def promote
		user_login = params[:user]
		@user = User.find_by(email: user_login)
		if @user.authority != 4
			@user.update_column(:authority, @user.authority+1)
		end
		redirect_to(:action => :write)
	end

	#move to Admin COntroller
	def demote
		user_login = params[:user]
		@user = User.find_by(email: user_login)
		if @user.authority != 1
			@user.update_column(:authority, @user.authority-1)
		end
		redirect_to(:action => :write)
	end

	#move to Admin COntroller
	def delete
		user_login = params[:user]
		@user = User.find_by(email: user_login)
		@user.destroy
		redirect_to(:action => :write)
	end
	#move to Admin COntroller
	def admin
		@users = User.all.where(authority: 1)
	end

	#move to Admin COntroller
	def companies
		@companies = Company.all.where(accredited: false)
	end

end
