class SellersController < ApplicationController

  def shares
    @seller = User.find(current_user.id)
    @shares = @seller.liquidate_shares
    share_number = @shares.first.number_shares
    @company = @seller.liquidate_shares.first.company
    @bids = Bid.where("number_of_shares <=  #{share_number}", ).where(company_id: @company.id).order("created_at DESC")
  end

  def edit
    @seller = current_user
    @share = LiquidateShare.find(params[:id])
  end

  def update
    share = LiquidateShare.find(params[:share_id])
    number = params[:number].delete(',').to_i
    share.update(number_shares: number, shares_price: params[:price])
    redirect_to :shares
  end

  def check_status
    client = DocusignRest::Client.new
    @response = client.get_envelope_recipients(
      envelope_id: "24b3d690-666a-4b08-9ac7-85212adce74e",
      include_tabs: true,
      include_extended: true
    )
  end


end
