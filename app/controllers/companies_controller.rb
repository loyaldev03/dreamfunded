class CompaniesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :company_profile]
	before_action :verify, except: [:index, :company_profile]
	before_action :admin_check, only: [:new, :edit, :make_team, :make_profile]

	def index
		@companies = Company.all_accredited
	end

	def new
		@company = Company.new
	end

	def company_profile
		if params[:id] != nil
			@id = params[:id]
			@company = Company.find(params[:id])
			@financial_details = @company.financial_detail
			@progress = @company.invested_amount / @company.goal_amount rescue 0
			@comments = @company.comments
			@members = @company.founders
			@section = @company.sections.first
		else
			redirect_to "/companies"
		end
	end

	def edit_profile
		if current_user == nil || current_user.authority < User.Authority[:Admin]
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

	def create
		@company = Company.new(company_params)
		if @company.save
			@company.campaign = Campaign.create
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
	end

	def edit
		@companies = Company.all
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
	end

	def add_team_member
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
		@section = @company.sections.first
	end

	def submit_profile
		@company = Company.find(params[:section][:id])
		@section = @company.sections.first

		if @section.update(section_params)
			redirect_to "/companies"
		else
			@error_message3 = ""
			section.errors.full_messages.each do |error|
				@error_message3 = @error_message3 + error + ". "
			end
			flash[:problem] = @error_message3
			redirect_to "/companies/make_profile/#{@company.id}"
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

private
	def verify
	 	user = User.find(current_user)
	 	if user.confirmed == false
	 		redirect_to url_for(:controller => 'home', :action => 'unverified')
	 	end
	end

	def admin_check
		if current_user.authority < User.Authority[:Founder]
			redirect_to url_for(:controller => 'home', :action => 'unauthorized')
		end
	end

	def section_params
		params.require(:section).permit(:id, :company_id, :overview, :target_market, :current_investor_details, :detailed_metrics, :customer_testimonials, :competitive_landscape, :planned_use_of_funds, :pitch_deck, :created_at, :updated_at)
	end

	def company_params
	  params.require(:company).permit(:image, :end_date, :document, :hidden, :position, :docusign_url, :name, :description,
	  :image, :invested_amount, :website_link, :video_link, :goal_amount, :status, :CEO, :CEO_number,
	   :display, :days_left, :created_at, :updated_at, :suggested_target_price,
	  financial_detail_attributes: ["offering_terms", "fin_risks", "income", "totat_income", "total_taxable_income",
				       "total_taxes_paid", "total_assets_this_year", "total_assets_last_year", "cash_this_year", "cash_last_year",
				       "acount_receivable_this_year", "acount_receivable_last_year", "short_term_debt_this_year", "short_term_debt_last_year",
				       "long_term_debt_this_year", "long_term_debt_last_year", "sales_this_year", "sales_last_year", "costs_of_goods_this_year",
				       "costs_of_goods_last_year", "taxes_paid_this_year", "taxes_paid_last_year", "net_income_this_year", "net_income_last_year",
				       "company_id","balance_sheet", "income_statements", "statement_of_cash_flow", "statement_changes_of_equity",
				       "business_plan", "party_transaction", "intended_use_of_proceeds", "capital_structure", "material_terms",
				        "financial_conditions", "directors_background", "accountant_review"]  )
	end

	def founder_params
		params.require(:founder).permit(:image, :name, :position, :content, :company_id, :created_at, :updated_at)
	end
end
