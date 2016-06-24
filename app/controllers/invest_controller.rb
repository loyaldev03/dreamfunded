class InvestController < ApplicationController
  before_action :set_company, :set_user
  include InvestHelper

  def personal
    @investor = @user.investor
  end

  def personal_submit
    @user.investor.update( investor_params )
    redirect_to investor_details_path(@company.name)
  end

  def investor_details
  end

  def investor_details_submit
    @user.investor.update(annual_income: params[:annual_income], new_worth: params[:new_worth],
     us_citizen: params[:us_citizen], exempt_withholding: params[:exempt_withholding] )

    redirect_to educational_disclaimer_path(@company.name)
  end

  def educational_disclaimer
  end

  def educational_disclaimer_submit
    redirect_to pre_purchase_path(@company.name)
  end

  def pre_purchase
    @maximum_investment =  maximum_investment(@user.investor)
  end

  def pre_purchase_submit
    maximum = params[:maximum].to_i
    number_of_shares = params[:share_amount]
    amount = @company.suggested_target_price * number_of_shares.to_i
    if amount > maximum
      flash[:maximum] = "Requiested amount of $#{amount} is larger than the maximum allowed"
      redirect_to pre_purchase_path(@company.name)
    else
      redirect_to(:action => :subscription, amount: amount,number_of_shares: number_of_shares, company_id: @company.id)
    end
  end

  def subscription
    @number_of_shares = params[:number_of_shares]
    @company_id = params[:company_id]
    @amount = params[:amount].to_i
  end

  def subscription_agreement_submit
    @number_of_shares = params[:number_of_shares]
    @company_id = params[:company_id]
    @amount = params[:amount]
    redirect_to(:action => :payment, amount: @amount,number_of_shares: @number_of_shares, company_id: @company_id)
  end

  def payment
    @number_of_shares = params[:number_of_shares]
    @company_id = params[:company_id]
    @amount = params[:amount]
  end

  private
  def set_company
    @company = Company.find_by(name: params[:name])
  end

  def set_user
    id = user_session.id
    @user = User.find(id)
  end

  def investor_params
    params.require(:investor).permit(
      "annual_income", "new_worth", "us_citizen", "exempt_withholding", "ssn", "country", "date_of_birth", "address",
      "city", "state", "zipcode", "user_id", "drive_license", "image" )
  end

end
