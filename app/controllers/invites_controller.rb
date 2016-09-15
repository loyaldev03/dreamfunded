class InvitesController < ApplicationController

  def invite
    @invites = Invite.where(user_id: current_user.id).where.not(email: nil).reverse
  end

  def create
    @invite = Invite.create(email: params[:invite][:email], user_id: current_user.id)
    email = params[:invite][:email]
    name = params[:name]
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

  def test
    ContactMailer.invite_to_sign_up.deliver
  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :email, :token)
  end
end
