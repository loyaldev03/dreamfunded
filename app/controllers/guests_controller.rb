class GuestsController < ApplicationController

  def index
    @guests = Guest.all
    respond_to do |format|
        format.html
        format.csv { send_data @guests.to_csv, filename: "subscribers-#{Date.today}.csv" }
    end
  end

  def create
    @guest = Guest.new(guest_params)
    respond_to do |format|
      if @guest.save
        SubscribeJob.new.async.perform(@guest.id)
        format.html { redirect_to root_path, notice: 'guest was successfully created.' }
        format.json { render nothing: true, status: :created, location: @guest }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def marketplace
    @guest = Guest.new(email: params[:email])
    respond_to do |format|
      if @guest.save
        SubscribeJob.new.async.mailchimp_subscribe(@guest.id)
        format.html { redirect_to root_path, notice: 'guest was successfully created.' }
        format.json { render nothing: true, status: :created, location: @guest }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def unsubscribe
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def guest_params
    params.require(:guest).permit(:email)
  end

end
