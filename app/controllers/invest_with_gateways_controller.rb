class InvestWithGatewaysController < ApplicationController
  include InvestWithGatewaysHelper
  protect_from_forgery except: [:hook]

  # POST /registrations

  def new
  end
  def create
  end

  #Paypal
  def invest_for_company
		@company = Company.where('lower(name)=?', params[:id].downcase).first
    offering_id = "kheizlUUSeukdA3iUl3Xtg"
    @offering = FundAmerica::Offering.details(offering_id)
    issuer_id = @offering["entity_url"].split("/")[-1]
    @issuer = FundAmerica::Entity.details(issuer_id)
    @wire_details = @offering["wire_details"]
		@user = User.find_by(id: params[:user_id])
    @min_investment_amount = @offering["min_investment_amount"]
    @max_investment_amount = @offering["max_investment_amount"]
  end
  
  def invest_with_paypal
    @company = Company.where('lower(name)=?', params[:id].downcase).first
    redirect_to paypal_url(return_from_paypal_path(current_user, @company))
  end

  def return_from_paypal
    @company = Company.where('lower(name)=?', params[:id].downcase).first
    @user = User.find_by(id: params[:user_id])
    redirect_to invest_for_company_path(@user, @company)      
  end
  

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"

    end
    render nothing: true
  end


  #Plaid
  def authenticate_bank_account_for_plaid
    begin
      @exchange_token = Plaid.exchange_token(link_plaid_params[:public_token])
      access_token = @exchange_token.access_token
      user = Plaid.set_user(access_token, ['auth'])
      bank_type = user.accounts[0].institution_type
      auth_info = user.clone #account & routing number
      upgrade_user = user.upgrade('info') #user information
      if !current_user.bank_info 
        current_user.bank_info = []
      end
      is_existing = 0
      current_user.bank_info.each do |bank|
        if bank[:bank_type] === bank_type
          is_existing = 1
          break
        end
      end
      bank = {
        :bank_type => bank_type,
        :access_token => access_token,
        :auth_info => auth_info,
        :info => upgrade_user
      }
      if (is_existing === 0)
        current_user.bank_info.push(bank)
      end
      if current_user.save
        respond_to do |format|
          format.html
          format.json { render json: bank, status: "200" }
        end
      else
        respond_to do |format|
          format.html
          format.json { render json: bank, status: "500" }
        end        
      end

    rescue => e
      Rails.logger.error "Error: #{e}"
      Rails.logger.error e.backtrace.join("\n")
      respond_to do |format|
        format.html
        format.json { render json: {}, status: "500" }
      end
    end
  end

  def update_bank_account_for_plaid
    begin
      exchange_token = Plaid.exchange_token(link_plaid_params[:public_token])

      @accounts =PlaidAccount.where(owner_type: link_plaid_params[:owner_type],
      owner_id: link_plaid_params[:owner_id])
      @accounts.each do |account|
        account.update(access_token: exchange_token.access_token)
      end
      flash[:success]="You have successfully updated your account(s)"
    rescue => e
      Rails.logger.error "Error: #{e}"
      Rails.logger.error e.backtrace.join("\n")
      render text: e.message, status: 500
    end
  end

  def get_bank_info_for_current_user
    if current_user.bank_info
      respond_to do |format|
        format.html
        format.json { render json: current_user.bank_info, status: "200"}
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: {}, status: "200"}
      end
    end      
  end

  def update_selected_account_for_current_user
    selected_bank_account = {bank_type: params["bank_type"], account_order: params["account_order"]}
    current_user.selected_bank_account = selected_bank_account
    if current_user.save
      respond_to do |format|
        format.html
        format.json { render json: selected_bank_account, status: "200"}
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: {}, status: "500"}
      end      
    end
  end

  def get_selected_accont_for_current_user
    if current_user.selected_bank_account
      respond_to do |format|
        format.html
        format.json { render json: current_user.selected_bank_account, status: "200"}
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: {}, status: "200"}
      end
    end
  end

  def index
  end
  def show
  end

private
  def paypal_url(return_path)
  	id = SecureRandom.random_number(1000000)
    price = 1000 * 100;
    item_name = 'car';
    item_number = SecureRandom.random_number(10000)
    values = {
        business: "#{Rails.application.secrets.merchant_account}",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: price,
        item_name: item_name,
        item_number: item_number,
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query  	
  end

  def link_plaid_params
    params.permit(:access_token, :public_token, :type,:name,:owner_id,:owner_type)
  end  
end