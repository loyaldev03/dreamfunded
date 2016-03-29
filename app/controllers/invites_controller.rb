class InvitesController < ApplicationController

  def invite
  end

  def create
    @invite = Invite.create(email: params[:invite][:email], user_id: user_session.id)
    ContactMailer.invite(@invite).deliver
  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :email, :token)
  end
end
