class HomeController < ApplicationController
	def index
		@user = User.find_by(login: session[:current_user])
	end


	def about
	end

	def team
		
	end

end
