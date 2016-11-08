class ContactMailer < ActionMailer::Base
  default from: "DreamFunded <info@dreamfunded.com>"

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
    mail(to: "info@dreamfunded.com", subject: 'Guest Contacted From DreamFunded website')
  end

  def account_created(user)
    @name = user.last_name
    @email= user.email
    mail(to: ["info@dreamfunded.com","info@dreamfunded.com"], subject: 'New Account Created')
  end

  def personal_hello(user)
    @name = user.first_name
    @email= user.email
    mail(to: @email, subject: 'Following up', from: 'Manny Fernandez <manny@dreamfunded.com>')
  end

  def reset_password_request(user)
    @name = user.last_name
    @email= user.email
    mail(to: "info@dreamfunded.com", subject: 'Password Reset Request')
  end

  def invite(invite)
    @email = invite.email
    @name = invite.user.name
    @token = invite.token
    mail(to: @email, subject: "Congratulations, #{@name} has given you $100 to invest on DreamFunded")
  end

  def campaign_submitted(user)
    mail(to: user.email, subject: 'Campaign Submitted')
  end

  def check_campaign(campaign)
    @campaign = campaign
    mail(to: "info@dreamfunded.com", subject: 'Company Submitted')
  end

  def investment_submitted(user, investment_id)
    @user = user
    @investment = Investment.find(investment_id)
    mail(to: user.email, subject: "Your DreamFunded Investment in #{@investment.company.name} Has Been Submitted")
  end

  def new_comment(comment)
    @comment = comment
    @user = comment.user
    mail(to: "info@dreamfunded.com", subject: 'New Comment')
  end

  def new_comment_company_owner(comment)
    @comment = comment
    @user = comment.company.users.last
    mail(to: @user.email, subject: 'New Comment under Your Company')
  end

  def invite_to_sign_up(email, name)
    mail(to: email, subject: "#{name.try(:capitalize)}, please accept my invite to DreamFunded")
  end

  def csv_invite(invite, user_name, user_company)
    @invite = invite
    @user_name = user_name
    @user_company = user_company
    mail(to: @invite.email, subject: "Hi #{@invite.try(:name).try(:capitalize)}, it's #{@user_name}. Check out my startup on DreamFunded.")
  end

  def invite_cofounder_exist(email, name, current_user)
    @email = email
    @name = name
    @current_user = current_user
    @company = current_user.company
    mail(to: email, subject: "#{@current_user.name} has invited you to collaborate on #{@company.name} ")
  end

  def invite_cofounder_dont_exist(email, name, current_user)
    @email = email
    @name = name
    @current_user = current_user
    @company = current_user.company
    mail(to: email, subject: "#{@current_user.name} has invited you to collaborate on #{@company.name} ")
  end

  def file_uploaded(user)
    @user = user
    mail(to: "manny@dreamfunded.com", subject: "#{@user.name} uploaded CSV file")
  end

  def invite_from_member(email, name, member)
    @email = email
    @name = name
    @member = member
    mail(to: email, subject: "Hi #{@name}, your friend #{@member.name} has invited you to join DreamFunded" )
  end

  def send_from_advisor(invite, advisor_name)
    @advisor = advisor_name
    @email = invite.email
    @name = invite.name
    mail(to: @email, subject: "Hi #{@name}, your friend #{@advisor} has invited you to join DreamFunded" )
  end

end
