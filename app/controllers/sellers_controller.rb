class SellersController < ApplicationController

  def shares
    @seller = user_session
    @shares = @seller.liquidate_shares
  end

end
