class InvitesController < ApplicationController
  require 'net/http'

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


  def upload_csv
    #begin
        @invite = Invite.create(invite_params)
        # paperclip_content =   Paperclip.io_adapters.for(@invite.file).read
        # import = ImportUserCSV.new(content: paperclip_content ) do
        # token = SecureRandom.uuid.gsub(/\-/, '').first(10)

        #   after_save do |invite|
        #       invite.token = token
        #       invite.save
        #   end
        # end

        # import.run!
        # p import.valid_header? # => true
        # p import.report.success? # => false
        # p import.report.status # => :aborted
        # p import.report.message # => "Import aborted"

        # last_token = Invite.last.token
        # new_invites = Invite.where(token: last_token)
        # new_invites.update_all(user_id: user.id)

        # new_invites.each do |invite|
        #   ContactMailer.delay.invite_to_sign_up(invite.email, invite.name) if email_template == 'from_Manny'
        #   ContactMailer.delay.csv_invite(invite, user) if email_template == 'from_Startup'
        # end
        SubscribeJob.new.async.csv_importer_gem(@invite,current_user, 'from_Startup')
        flash[:email_sent] = "Emails sent"
        redirect_to  invite_users_path
    #  rescue
    #     flash[:upload_error] = "Invalid CSV file format."
    #     redirect_to  invite_users_path
    # end
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



  def download

    send_file(Rails.root.join('app' , 'assets', 'doc', "test_users.csv"))
  end

  def invite_cofounder

  end

  def post_invite_cofounder
    email = params[:email]
    name = params[:name]
    invited_person = User.find_by(email: email)
    CoFounder.create(email: email, name: name, user_id: current_user.id)
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
    params.require(:invite).permit(:user_id, :email, :token, :name, :file)
  end
end

