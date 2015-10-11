class ContactMailer < ActionMailer::Base
  default from: "DreamFunded <info@dreamfunded.com>"


  def welcome_email(user)

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
end
