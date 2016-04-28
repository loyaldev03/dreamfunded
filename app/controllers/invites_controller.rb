class InvitesController < ApplicationController

  def invite
    @invites = Invite.where(user_id: user_session.id)
  end

  def create
    @invite = Invite.create(email: params[:invite][:email], user_id: user_session.id)
    ContactMailer.invite(@invite).deliver
  end

  def google_contacts
    emails = params[:emails]
    emails.each do |email|
      @invite = Invite.create(email: email, user_id: user_session.id)
      ContactMailer.invite(@invite).deliver
    end
    redirect_to '/invite'
  end

  def accept
    @token = params[:token]
    @email = params[:email]
  end

  def create_from_social
    user = User.find(params[:id])
    if user
      @invite = Invite.create(user_id: user.id)
      redirect_to action: accept, token: @invite.token
    end
    redirect_to root_path
  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :email, :token)
  end
end
