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
			company = current_user.companies.last
			if company.campaign.finished?
				redirect_to(:controller => 'companies', :action => :company_profile, id: company.id)
			else
				redirect_to edit_campaign_path(company.campaign.id)
			end
		else
			redirect_to  funding_goal_path
		end
	end
end
