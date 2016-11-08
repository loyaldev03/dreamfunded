class UsersController < ApplicationController
	invisible_captcha only: [:create]
	before_action :authenticate_user!, only: [:portfolio, :campaign]

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

	def become
	    return unless current_user.authority == User.Authority[:Admin]
	    sign_in(:user, User.find(params[:id]))
	    redirect_to root_url # or user_root_url
	end

	def advisors
		@advisors = User.where(advisor: true)
	end

	# def campaign
	# 	if current_user.companies.any?
	# 		company = current_user.companies.last
	# 		if company.campaign.finished?
	# 			redirect_to(:controller => 'companies', :action => :company_profile, id: company.id)
	# 		else
	# 			redirect_to edit_campaign_path(company.campaign.id)
	# 		end
	# 	else
	# 		redirect_to  funding_goal_path
	# 	end
	# end

	def campaign
		if current_user.company
			company = current_user.company
			campaign = company.campaign
			if campaign.submitted?
				redirect_to(:controller => 'companies', :action => :show, id: company.slug)
			else
				campaign_step = find_campaign_step(campaign.current_state, campaign.id)
				redirect_to campaign_step
			end
		else
			redirect_to  funding_goal_path
		end
	end

private
	def find_campaign_step(page,id)
		if page == 'goal'
        	return funding_goal_exist_path(id)
      	elsif page == 'basics'
        	return campaign_basics_path(id)
        elsif page == 'description'
          	return description_path(id)
        elsif page == 'legal'
          	return legal_info_path(id)
        elsif page == 'financial'
          	return financial_info_path(id)
        else
        	return funding_goal_path
        end
	end
end
