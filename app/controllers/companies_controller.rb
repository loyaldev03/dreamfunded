class CompaniesController < ApplicationController
	def index
		@companies = Companies.all

	end
end
