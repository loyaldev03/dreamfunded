class BidsController < ApplicationController

	#Default site that shows all startups
	def index
		@bids = Bid.where(user_id: user_session.id.to_s)
	end

  #improve associations later
  def sellers_bids
    @seller = user_session
    @company = @seller.liquidate_shares.first.company
    @bids = Bid.where(company_id: @company.id)
  end

  def bid
    @company = Company.find(params[:id])
  end

  def new
    @id = params[:id]
    @company = Company.find(params[:id])
    @progress = @company.invested_amount / @company.goal_amount rescue 0

    @members = @company.founders
    @section = @company.sections.first

    @bid = Bid.find_by(user_id: user_session.id, company_id: @id)
    @bid = Bid.new if @bid == nil
  end

  def create
    @bid = Bid.new(bid_params)
      if @bid.save
        user_ids = LiquidateShare.where(company_id: @bid.company_id).pluck(:user_id)
        sellers = User.where(id: user_ids)
        sellers.each do |seller|
          ContactMailer.bid_created(seller, @bid).deliver
        end
        redirect_to bids_path
        #send email to all sellers
        #ContactMailer.bid_created().deliver
      else
        render :new
      end
  end

  def edit
  end

  def update
    bid = Bid.find(params[:id])
    if bid.update(bid_params)
      redirect_to bids_path
    else
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
    @auctions = LiquidateShare.where(company: @company.name)
  end


  def decline
    bid = Bid.find(params[:id])
    ContactMailer.bid_declined(bid).deliver
    bid.delete
    redirect_to :sellers_bids
  end

  def counter_offer
    @seller = user_session
    @bid = Bid.find(params[:id])
  end

  def send_counter_offer
    price = params[:price]
    number = params[:number]
    @bid = Bid.find(params[:bid_id])
    @bid.update(counter_amount: price, status: 'Counter Offer')
    ContactMailer.counter_offer(@bid, price, number).deliver
    redirect_to shares_path
  end

  def confirm
    @bid = Bid.find(params[:id])
    @total = @bid.bid_amount * @bid.number_of_shares
  end

  def accept
    @bid = Bid.find(params[:id])
    @bid.update(status: 'Accepted')
    @seller = user_session
    docusign(@bid, user_session)
    ContactMailer.seller_accepts_offer(@bid, @seller).deliver
    ContactMailer.your_offer_win(@bid).deliver
    redirect_to shares_path
  end

  def update_bid_offer
    bid = Bid.find(params[:id])
    price = params[:price]
    amount = params[:number]
    bid.update(bid_amount: price, number_of_shares: amount, status: 'Reviewing')
    redirect_to bids_path
  end

  protected

  def docusign(bid, seller)
    @client = DocusignRest::Client.new
    @document_envelope_response = @client.create_envelope_from_document(
      email: {
        subject: "test email subject",
        body: "this is the email body and it's large!"
      },
      # If embedded is set to true  in the signers array below, emails
      # don't go out to the signers and you can embed the signature page in an
      # iFrame by using the client.get_recipient_view method
      signers: [
        {
          embedded: false,
          name: 'Test Guy',
          email: bid.user.email,
          role_name: 'buyer',
          sign_here_tabs: [
            {
              anchor_string: '---------------------',
              anchor_x_offset: '140',
              anchor_y_offset: '8'
            }
          ]
        },
        {
          embedded: false,
          name: 'Test Girl',
          email: seller.email,
          role_name: 'seller',
          sign_here_tabs: [
            {
              anchor_string: '---------------------',
              anchor_x_offset: '140',
              anchor_y_offset: '8'
            }
          ]
        }
      ],
      files: [
        {path: "#{Rails.root}/app/assets/doc/test.pdf", name: 'test.pdf'}
      ],
      status: 'sent'
    )
  end


  private
  def bid_params
    params.require(:bid).permit(:auction_id, :user_id, :seller_id, :bid_amount, :counter_amount, :accepted, :company_id,:number_of_shares)
  end
end

