class ApplicationController < ActionController::Base
    helper_method :authority

    # def user_session
    # 	session[:current_user]
    # end

    def authority
    	User.Authority
    end
end
