class SellersController < ApplicationController

  def shares
    @seller = user_session
    @shares = @seller.liquidate_shares
    @company = @seller.liquidate_shares.first.company
    @bids = Bid.where(company_id: @company.id).order("created_at DESC")
  end

end
