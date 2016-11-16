class OmniauthCallbacksController < ApplicationController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      p "I AM HERE 1"
      sign_in_and_redirect @user
    else
      p "I AM HERE 2"
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    p request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, notice:'Signed In'
    else
      session["devise.user_attributes"] = @user.attributes
      flash[:signup_errors] = @user.errors.full_messages.first
      redirect_to new_user_registration_url
    end
  end
  alias_method :google, :google_oauth2

  def omniauth_failure
    p '$$$$$$$$$$$$$$$$$$$$$$$$$$$'
    p params

    flash[:signup_errors] = params.first.try(:last)

    redirect_to new_user_registration_path
    #redirect wherever you want.
  end

end
