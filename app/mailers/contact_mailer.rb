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
    @user = comment.company.user
    mail(to: @user.email, subject: 'New Comment under Your Company')
  end

  def invite_to_sign_up(email, name)
    mail(to: email, subject: "#{name}, please accept my invite to DreamFunded")
  end

  def csv_invite(invite, user)
    @invite = invite
    @user = user
    mail(to: @invite.email, subject: "Hi #{@invite.name}, it's #{@user.name}. Check out my startup on DreamFunded.")
  end
end
