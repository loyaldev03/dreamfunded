class ApplicationController < ActionController::Base
    helper_method :authority
    before_action :logout_user_session

    # def user_session
    # 	session[:current_user]
    # end

    def authority
    	User.Authority
    end

    def logout_user_session
      session[:current_user] = nil
    end
end
