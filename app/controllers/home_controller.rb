class HomeController < ApplicationController
	invisible_captcha only: [:liquidate_form, :contact_us_send_email, :get_funded_send]

	def index
	end

	def about
		@posts = Post.order(:position).where(page: 'about_us')
	end

	def privacy_policy
	end

	def get_started
		if current_user == nil
			redirect_to "/users/sign_up"
		else
			redirect_to "/companies"
		end
	end

	def unauthorized
	end

	def unverified
	end

	def faq
		@posts = Post.order(:position).where(page: 'faq')
	end

	def howItWorks
		@posts = Post.order(:position).where(page: 'how_works')
	end

	def legal
		# sandbox_key FundAmerica.api_key = 'HGW5qJtVbIM7AWLxWg-KG40DqDQpV-iS'
		FundAmerica.api_key = 'nSgy4St7K_vFsyaBXypCI6ls6SGEFduM'
		FundAmerica.mode = 'production'

		begin
		  offering = FundAmerica::Offering.details("-O119J6jTjC8GFLEZJ5sGA")
		  p '**************************'
		  p offering["funds_in_escrow"]

		rescue FundAmerica::Error => e
		  # Print response from FundAmerica API in case of unsuccessful response
		  puts e.parsed_response
		end
	end

	def contact_us
	end

	def contact_us_send_email
		@name = params[:name]
		@email = params[:email]
		@phone = params[:phone]
		@message = params[:message].first
		ContactMailer.contact_us_email(@name, @email, @phone, @message).deliver
		flash[:notice] = 'Thank you'
		redirect_to '/contact'
	end

	def resources
	end

	def marketplace
	end

	def book
	end

private
   def liquidate_share_params
   	params.require(:liquidate_share).permit(:first_name, :last_name, :email,  :phone, :company, :number_shares, :shares_price, :timeframe, :rofr_restrictions, :financial_assistance, :message)
   end
end
