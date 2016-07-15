class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
      @user.update_attribute(:authority, 2)
      ContactMailer.verify_email(@user).deliver
      ContactMailer.account_created(@user).deliver
    end
  end

protected
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end
end
