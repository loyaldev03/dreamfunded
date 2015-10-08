class ContactMailer < ActionMailer::Base
  default from: "dreamfundedmembership@gmail.com"

  def welcome_email(user)

  end

  def reset_email(user)
    @user = user
    mail(to: user.email, subject: "Reset Password Instructions")
  end
end
