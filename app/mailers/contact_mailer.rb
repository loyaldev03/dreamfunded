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
    # mail(to: "alexandr.larionov88@gmail.com", subject: 'Guest Contacted From DreamFunded website')
  end

  def liquidate_email(name, email, phone, message)
    @name = name
    @email= email
    @phone = phone
    @message = message
    mail(to: "info@dreamfunded.com", subject: 'Request to liquidate shares')
    # mail(to: "alexandr.larionov88@gmail.com", subject: 'Request to liquidate shares')
  end

  def account_created(user)
    @name = user.last_name
    @email= user.email
    mail(to: "info@dreamfunded.com", subject: 'New Account Created')
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
end
