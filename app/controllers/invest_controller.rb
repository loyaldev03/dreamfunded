class InvestController < ApplicationController
  before_action :set_company

  def personal
    @user = user_session
  end

  def personal_submit
    user = User.find(params[:user_id])
    Investor.create( country: params[:country], ssn: params[:ssn], date_of_birth: params[:date_of_birth],
    address: params[:address], city: params[:city], state: params[:state], zipcode: params[:zipcode],
    drive_license: params[:drive_license], user_id: user.id, image: params[:image])

    redirect_to investor_details_path(@company.name)
  end

  def investor_details
    @user = user_session
  end

  def investor_details_submit
    user = User.find(params[:user_id])
    user.investor.update(annual_income: params[:annual_income], new_worth: params[:new_worth],
     us_citizen: params[:us_citizen], exempt_withholding: params[:exempt_withholding] )

    redirect_to educational_disclaimer_path(@company.name)
  end

  def educational_disclaimer
    @user = user_session
  end

  def educational_disclaimer_submit
    redirect_to pre_purchase_path(@company.name)
  end

  def pre_purchase
    @user = user_session
  end

  def pre_purchase_submit
    number_of_shares = params[:share_amount]
    amount = @company.suggested_target_price * number_of_shares.to_i
    redirect_to(:action => :payment, amount: amount)
  end

  def payment
    @amount = params[:amount]
  end

  private
  def set_company
    @company = Company.find_by(name: params[:name])
  end



end
