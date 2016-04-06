class SellersController < ApplicationController

  def shares
    @seller = user_session
  end

end
