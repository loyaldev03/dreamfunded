class FormcController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_format, only: [:print]
  before_action :editor_check, only: [:show, :edit, :update ]

  def show
    @general_info = GeneralInfo.find(params[:id])
  end

  def edit
    @general_info = GeneralInfo.find(params[:id])
  end

  def update
    @general_info = GeneralInfo.find(params[:id])
    @general_info.update(general_info_params)
    redirect_to action: :show, id: @general_info.id
  end


  def general
    @general_info = GeneralInfo.new
    @company = Company.friendly.find(params[:id])
  end

  def general_save
    @company = Company.find(params[:general_info][:company_id])
    info = GeneralInfo.create(general_info_params)
    @company.general_infos << info
    redirect_to action: :people, id: info.id
  end


  def people
    @general_info = GeneralInfo.find(params[:id])
    if @general_info.officers.count > 0
      @officers = @general_info.officers
    else
      @officer = Officer.new(position: 'CEO')
    end
    @holders = @general_info.principal_holders
  end

  def people_save
    @general_info = GeneralInfo.find(params[:id])
    @general_info.update(general_info_params)
    redirect_to action: :terms, id: @general_info.id
  end


  def terms
    @general_info = GeneralInfo.find(params[:id])
    @perks = [InvestmentPerk.new(amount: 250), InvestmentPerk.new(amount: 500),InvestmentPerk.new(amount: 1000), InvestmentPerk.new(amount: 5000)]
    @term = Term.new
  end

  def terms_save
    @general_info = GeneralInfo.find(params[:id])
    @general_info.update(general_info_params)
    redirect_to action: :disclosures, id: @general_info.id
  end

  def disclosures
    info = GeneralInfo.find(params[:id])
    @general_info = GeneralInfo.find(params[:id])
    @risk = Risk.new
    @tier = FundraiseTier.new(amount: 20000)
  end

  def disclosure_save
    @general_info = GeneralInfo.find(params[:id])
    @general_info.update(general_info_params)
    redirect_to action: :financials, id: @general_info.id
  end

  def financials
    @general_info = GeneralInfo.find(params[:id])
  end

  def financials_save
     @general_info = GeneralInfo.find(params[:id])
     @general_info.update(general_info_params)
     #ContactMailer.formc_submitted(current_user, @general_info).deliver
     redirect_to "/formc/pdf/#{@general_info.id}.pdf"
  end

  def pdf
    @general_info = GeneralInfo.find(params[:id])
    render :layout => false
  end

  def print
    @general_info = GeneralInfo.find(params[:id])
    info = @general_info
    respond_to do |format|
      format.pdf { send_file TestPdfForm.new(info).export("tmp/formc_#{info.name}.pdf"), type: 'application/pdf' }
    end
  end

private

  def editor_check
    if current_user.authority <= User.Authority[:Editor]
      redirect_to url_for(:controller => 'home', :action => 'unauthorized')
    end
  end

  def set_format
    request.format = 'pdf'
  end

  def general_info_params
    params.require(:general_info).permit("name", "completed", "days", "cap_table", "kind", "state", "date_formed", "employees_numer", "company_location_address", "company_location_city", "company_location_state", "company_location_zipcode",
                                         "website", "employer_id_number", "financial_condition", "outstanding_loan","business_model", "business_plan", :ceo,
                                         :business_history, :product_description, :competition, :customer_base, :intellectual_property, :min_amount, :company_description,
                                         :governmental_regulatory, :litigation, :phone, :type_of_securtity,:legal_name, :max_amount, :company_id, :min_investment, :maket_strategy, :discount,
                                        :position_title, :first_date, :prev_emp, :prev_title, :prev_dates, :prev_resp, :offering_purpose, :fin_condition, :price_of_securities, :number_of_securities,
                                        :rds, :rds_years, :upcoming_rd, :real_estate,
                                        :valuation, :burn_rate, :additional_financing, :additional_sources_capital, :additional_sources_necessary, :has_material_capital, :material_capital, :material_capital_expenditures,
                                        :transactin, :related_person, :conflicts,
        securities_attributes: [:security_class,  :_destroy, :amount, :outstanding, :voting_rights, :other_rights, :general_info_id, :securities_reserved, :created_at, :updated_at],
        principal_holders_attributes: [:name, :securities_held, :_destroy, :voting_power, :title, :general_info_id, :created_at, :updated_at],
        officers_attributes: [ "name", "employment", "email", "year_joined", "_destroy", "officers", "director", "position", "education", "occupation", "main_employer", "general_info_id", "created_at", "updated_at"],
        investment_perks_attributes: [:content, :amount,:_destroy],
        terms_attributes: [
          "safe_cap", "valuation_cap", "_destroy", "investor_threshold", "pro_rata?", "governing_law_state", "days", "raised_this_round", "discount", "store_credit", "store_discount", "general_info_id"
        ],
        fundraise_tiers_attributes: [:id, :content, :amount, :_destroy],
        risks_attributes: [:id, :content, :_destroy],
        financial_detail_attributes: ["id", "general_info_id", "sustain_amount", "total_taxable_income", "total_assets_this_year", "total_assets_last_year", "cash_this_year", "cash_last_year", "acount_receivable_this_year", "acount_receivable_last_year", "short_term_debt_this_year", "short_term_debt_last_year", "long_term_debt_this_year", "long_term_debt_last_year", "sales_this_year", "sales_last_year", "costs_of_goods_this_year", "costs_of_goods_last_year", "taxes_paid_this_year", "taxes_paid_last_year", "net_income_this_year", "net_income_last_year", ]

      )
  end

end
