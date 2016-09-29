class InvitesController < ApplicationController

  def invite
    @invites = Invite.where(user_id: current_user.id).where.not(email: nil).reverse
  end

  def create
    @invite = Invite.create(invite_params)
    email = @invite.email
    name = @invite.name
    ContactMailer.invite_to_sign_up(email, name).deliver
    redirect_to '/invite'
  end

  def google_contacts
    emails = params[:emails]
    emails.each do |email|
      @invite = Invite.create(email: email, user_id: current_user.id)
      ContactMailer.invite(@invite).deliver
    end
    redirect_to '/invite'
  end

  def send_csv_invites
    emails = params[:emails]
    names = params[:names]
    emails.each_with_index do |email, index|
      @invite = Invite.create(email: email,name: names[index], user_id: current_user.id)
      p names[index]
      ContactMailer.csv_invite(@invite, current_user).deliver
    end
    redirect_to '/invite'
  end

  def accept
    @token = params[:token]
    @email = params[:email]
  end

  def accept_from_facebook
    user = User.find(params[:id])
    if user
      invite = Invite.create(user_id: user.id)
      @token = invite.token
    end
  end

  def create_from_social
    user = User.find(params[:id])
    if user
      @invite = Invite.create(user_id: user.id)
      redirect_to :action => 'accept', :token => @invite.token
    else
      redirect_to root_path
    end
  end

  def upload_csv
    begin
        Invite.import(params[:file], current_user.id)
        redirect_to  view_uploaded_csv_path
      rescue
        redirect_to  invite_users_path, notices: "Invalid CSV file format."
    end
  end

  def view_uploaded_csv
    @invites = current_user.guests.reverse
  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :email, :token, :name)
  end
end
