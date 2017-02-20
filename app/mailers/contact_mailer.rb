class ContactMailer < ActionMailer::Base
  default from: "DreamFunded <mor1084leo@gmail.com>"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to DreamFunded")
  end

  def reset_email(user)
    @user = user
    mail(to: user.email, subject: "Reset Password Instructions")
  end

  def verify_email(user)
    @user = user
    mail(to: @user.email, subject: "Verify Email")
  end

  def contact_us_email(name, email, phone, message)
    @name = name
    @email= email
    @phone = phone
    @message = message
    mail(to: "mor1084leo@gmail.com", subject: 'Guest Contacted From DreamFunded website')
  end

  def account_created(user)
    # @name = user.last_name
    # @email= user.email
    # mail(to: ["mor1084leo@gmail.com","mor1084leo@gmail.com"], subject: 'New Account Created')
  end

  def personal_hello(user)
    @name = user.first_name
    @email= user.email
    mail(to: @email, subject: 'Following up', from: 'Manny Fernandez <info@dreamfunded.com>')
  end

  def personal_hello_to_investors(user)
    @name = user.first_name
    @email= user.email
    mail(to: @email, subject: 'Start Exploring DreamFunded Marketplace', from: 'Manny Fernandez <manny@dreamfunded.com>')
  end

  def personal_hello_to_entrepreneuers(user)
    @name = user.first_name
    @email= user.email
    mail(to: @email, subject: 'Getting Started Fundraising on DreamFunded', from: 'Manny Fernandez <manny@dreamfunded.com>')
  end

  def funding_goal_submit_email(user)
    @name = user.first_name
    @email= user.email
    mail(to: @email, subject: 'Your Application to DreamFunded Has Been Recieved!', from: 'Manny Fernandez <manny@dreamfunded.com>')
  end

  def reset_password_request(user)
    @name = user.last_name
    @email= user.email
    mail(to: "mor1084leo@gmail.com", subject: 'Password Reset Request')
  end

  # Invites
  def invite(invite)
    @email = invite.email
    @name = invite.user.name
    @token = invite.token
    mail(to: @email, subject: "Congratulations, #{@name} has given you $100 to invest on DreamFunded")
  end

  def campaign_submitted(user, company)
    @email = user.email
    @name = user.first_name
    @company_name = company.name
    mail(to: @email, subject: 'Your Application to DreamFunded Has Been Recieved!')
  end

  def check_campaign(user, campaign)
    @campaign = campaign
    @name = user.first_name + " " + user.last_name
    byebug
    @company_name = campaign.company.name
    @user = user
    @company = campaign.company
    @financial_detail = @company.financial_detail
    @documents = @company.documents
    @links = {website_link: @company.website_link, video_link: @company.video_link}
    subject = @name + '’s Company, ' + @company_name + ', Has Just  !'
    mail(to: "ptulr2016@gmail.com", subject: subject)
  end

  def send_accept_email_to_company(user, company)
    @email = user.email
    @name = user.first_name + " " + user.last_name
    mail(to: @email, subject: "DreamFunded Application Update")
  end
  def send_reject_email_to_company(user, comapny)
    @email = user.email
    @name = user.first_name + " " + user.last_name
    mail(to: @email, subject: "DreamFunded Application Update")
  end

  def investment_submitted(user, investment_id)
    @user = user
    @investment = Investment.find(investment_id)
    mail(to: user.email, subject: "Your DreamFunded Investment in #{@investment.company.name} Has Been Submitted")
  end

  def new_comment(comment)
    @comment = comment
    @user = comment.user
    mail(to: "mor1084leo@gmail.com", subject: 'New Comment')
  end

  def new_comment_company_owner(comment)
    @comment = comment
    @user = comment.company.users.last
    mail(to: @user.email, subject: 'New Comment under Your Company')
  end

  # Invites
  def invite_to_sign_up(email, name)
    mail(to: email, subject: "#{name.try(:capitalize)}, please accept my invite to DreamFunded")
  end

  # Invites
  def csv_invite(invite, user_name, user_company)
    @invite = invite
    @slug = Company.find_by(name: user_company).slug
    @user_name = user_name
    @user_company = user_company
    mail(to: @invite.email, subject: "Hi #{@invite.try(:name).try(:capitalize)}, it's #{@user_name}. Check out my startup on DreamFunded.")
  end

  # Invites
  def invite_cofounder_exist(email, name, current_user)
    @email = email
    @name = name
    @current_user = current_user
    @company = current_user.company
    mail(to: email, subject: "#{@current_user.name} has invited you to collaborate on #{@company.name} ")
  end

  # Invites
  def invite_cofounder_dont_exist(email, name, current_user)
    @email = email
    @name = name
    @current_user = current_user
    @company = current_user.company
    mail(to: email, subject: "#{@current_user.name} has invited you to collaborate on #{@company.name} ")
  end

  # Invites
  def file_uploaded(user)
    @user = user
    mail(to: "manny@dreamfunded.com", subject: "#{@user.name} uploaded CSV file")
  end

  # Invites
  def invite_from_member(email, name, member)
    @email = email
    @name = name
    @member = member
    mail(to: email, subject: "Hi #{@name}, your friend #{@member.name} has invited you to join DreamFunded" )
  end

  # Invites
  def send_from_advisor(invite, advisor)
    @advisor = advisor
    @email = invite.email
    @name = invite.name
    mail(to: @email, subject: "Hi #{@name}, your friend #{@advisor.name} has invited you to join DreamFunded" )
  end

  def new_investment_made(user, company_id)
    @company = Company.find(company_id)
    @user = user
    mail(to: "mor1084leo@gmail.com", subject: "New Investment made in #{@company.name}")
  end

  def join_group_request(user, group)
    @user, @group = user, group
    mail(to: "mor1084leo@gmail.com", subject: "#{@user.name} requested to join #{@group.name}")
  end

  def formc_submitted(user, formc)
    @user = user
    @formc = formc
    mail(to: "mor1084leo@gmail.com", subject: "#{@user.name} submitted Form C")
  end

end
