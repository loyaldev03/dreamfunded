class SignaturesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def new
  end

  def create_signature
	  embedded_request = create_embedded_request(name: params[:name], email: params[:email])
	  @sign_url = get_sign_url(embedded_request)
	  render :embedded_signature 
  end

  def callbacks
    render json: 'Hello API Event Received', status: 200
  end

private
	def create_embedded_request(opts = {})
		file = Rails.root.join('public/pdf.pdf').to_s
	  HelloSign.create_embedded_signature_request(
	    test_mode: 1, #Set this to 1 for 'true'. 'false' is 0
	    client_id: Rails.application.secrets.hello_sign_client_id,
	    subject: 'My first embedded signature request',
	    message: 'Awesome, right?',
	    signers: [
	      {
	        email_address: opts[:email],
	        name: opts[:name]
	      }
	    ],
	    files: [file]
	  )
	end

	def get_sign_url(embedded_request)
	  sign_id = get_first_signature_id(embedded_request)
	  HelloSign.get_embedded_sign_url(signature_id: sign_id).sign_url
	end

	def get_first_signature_id(embedded_request)
	  embedded_request.signatures[0].signature_id
	end
end