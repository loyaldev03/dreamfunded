class SellersController < ApplicationController

  def shares
    @seller = User.find(user_session.id)
    @shares = @seller.liquidate_shares
    @company = @seller.liquidate_shares.first.company
    @bids = Bid.where(company_id: @company.id).order("created_at DESC")
  end

  def edit
    @seller = user_session
    @share = LiquidateShare.find(params[:id])
  end

  def update
    share = LiquidateShare.find(params[:share_id])
    number = params[:number].delete(',').to_i
    share.update(number_shares: number, shares_price: params[:price])
    redirect_to :shares
  end


end
