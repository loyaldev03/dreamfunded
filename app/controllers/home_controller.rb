class HomeController < ApplicationController
	def index
		@user = session[:current_user]
		@Authority = User.Authority
	end

	def about

	end

	def team
		
	end

	def unauthorized

	end
	
end
