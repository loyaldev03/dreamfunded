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
        #Delayed jobs for Importing and Sendig 1000s emails
        #Invite.delay.import(params[:file], current_user)
        SubscribeJob.new.async.csv_save_emails(params[:file], current_user, 'from_Startup')
        # invites.each do |invite|
        #   ContactMailer.csv_invite(invite, current_user).deliver
        # end
        flash[:email_sent] = "Emails sent"
        redirect_to  invite_users_path
      rescue
        flash[:upload_error] = "Invalid CSV file format."
        redirect_to  invite_users_path
    end
  end

  def invites_from_manny
    begin
        SubscribeJob.new.async.csv_save_emails(params[:file], current_user, 'from_Manny')
        flash[:email_sent] = "Emails sent"
        redirect_to  invite_users_path
      rescue
        flash[:upload_error] = "Invalid CSV file format."
        redirect_to  invite_users_path
    end
  end

  def send_csv_invites
    emails = params[:emails]
    names = params[:names]
    emails.each_with_index do |email, index|
      @invite = Invite.create(email: email,name: names[index], user_id: current_user.id)
      ContactMailer.delay.csv_invite(@invite, current_user)
    end
    redirect_to '/invite'
  end

  def view_uploaded_csv
    @invites = current_user.guests.reverse
  end


  IMAGES_PATH = File.join( "assets", "docs")
  def download

    send_file(Rails.root.join('app' , 'assets', 'doc', "test_users.csv"))
  end

  def invite_cofounder

  end

  def post_invite_cofounder
    email = params[:email]
    name = params[:name]
    invited_person = User.find_by(email: email)
    Invite.create(email: email, name: name, user_id: current_user.id)
    if invited_person
      current_user.company.users << invited_person
      ContactMailer.invite_cofounder_exist(email, name, current_user).deliver
    else
      ContactMailer.invite_cofounder_dont_exist(email, name, current_user).deliver
    end
    redirect_to company_path(current_user.company)
  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :email, :token, :name)
  end
end
