class RegistrationsController < Devise::RegistrationsController

  def create
    super
    p "REGISTRATION CONTROLLER"
    if @user.persisted?
      @user.update_attribute(:authority, 2)
      ContactMailer.verify_email(@user).deliver
      ContactMailer.account_created(@user).deliver
    end
    check_if_was_invited(@user)
  end

protected
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def check_if_was_invited(user)
    email = user.email
    invited_person = user
    invite = Invite.find_by(email: email)
    if invite
      invite.user.company.users << invited_person
    end
  end

private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end
end
