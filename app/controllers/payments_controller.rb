require 'usaepay.rb'
class PaymentsController < ApplicationController
  before_action :authorize

  def index
    @user = session[:current_user]
	end

  def payment
    shares = params[:number_of_shares]
    company_id = params[:company_id]
    tran=UmTransaction.new
    # Merchants Source key must be generated within the console
    #production key
    #tran.key="azIZnB64RLfnc7yFhWbidTGTgkdq5p36"
    #sandbox key
    tran.key="p3681m70sjSf25eG2wplW7Y6MhTvdPD3"

    # Send request to sandbox server not production.  Make sure to comment or remove this line before
    #  putting your code into production
    tran.usesandbox = true

    # tran.card="4111111111111111"
    # tran.exp="0919"
    tran.command="check"
    tran.accounttype = "Checking"
    tran.billfname ='Alexandr'
    tran.billlname = 'Larionov'
    tran.billcity = 'San Francisco'
    tran.billstate = 'CA'

    tran.amount= params[:amount]

    #tran.cardholder="Test T Jones"
    tran.street="1234 Main Street"
    tran.zip="94116"
    tran.description="Online Order"
    #tran.cvv2="435"
    # tran.custom3="testest"
    #tran.pin="1234"
    tran.ip = request.remote_ip
    tran.dlnum = 'F2127533'
    tran.dlstate = 'CA'
    tran.cardholder = params[:name]
    tran.routing = params[:routing]
    tran.account = params[:account]


    $stdout.flush

    tran.process
    flash[:message] = tran.error
    if tran.resultcode.to_s=="A"
    then
      flash[:message] = tran.result
      flash[:message] = "Thank you. Your investment has been completed. You will receive an email from DreamFunded within 24 hours or less."
        p "Full result #{tran.result}"
        p "Authcode:  #{tran.authcode} "
        p "AVS Result: #{tran.avs_result} "
        p "Cvv2 Result: #{tran.cvv2_result} "

      # if referral give 100$
     # addCreditForReferral
      investment_id = createInvestment( params[:amount], company_id, shares)
      company_name = Company.find(company_id).name
      ContactMailer.investment_submitted(user_session, investment_id).deliver
      redirect_to congratulation_path(investment_id)
    else

      p "Card Declined #{tran.result} "
      p "Reason: #{tran.error}"
      redirect_to :back
    end
  end

  def congrats
    @investment = Investment.find(params[:id])
    @company_name = @investment.company.name
  end

  private

  def createInvestment(amount, company_id, shares)
    investment = Investment.create(user_id: user_session.id, company_id: company_id, invested_amount: amount, number_of_shares: shares)
    investment.id
  end


  def addCreditForReferral
    invite = Invite.find_by(email: user_session.email)
    if invite
      invite.user.increment!(:invite_credit, 100)
      invite.update(status: 'User Invested, you received $100 credit')
    end
  end

  def authorize
    if session[:current_user] == nil || session[:current_user].authority < User.Authority[:Accredited]
      redirect_to url_for(:controller => 'home', :action => 'unauthorized')
    end
  end

end
