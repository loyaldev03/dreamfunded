class OmniauthCallbacksController < ApplicationController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      @user.update(verified: true)
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    p request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      @user.update(confirmed: true)
      session[:current_user] = @user
      if @user.authority >= 2
        redirect_to root_path
      else
        redirect_to certify_path
      end
    else
      flash[:notice] = 'Unable to creaet a new user'
      p 'STEP 2'
      redirect_to 'users/new'
    end
  end

  alias_method :google, :google_oauth2
end
