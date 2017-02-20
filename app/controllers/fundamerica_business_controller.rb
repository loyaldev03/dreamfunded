class FundamericaBusinessController < ApplicationController

	def create_entity
	end

	def create_investment
		begin
			investor_entity = create_investor
			subscription_agreement = create_subscription_agreement
			sing_to_subscription_agreement(subscription_agreement)
			investment = nil
			byebug
			if (params[:payment_method] === "ach")
				investment = create_investment_for_ach(investor_entity)
			elsif (params[:payment_method] === 'wire') 	
				investment = create_investment_for_wire(investor_entity, subscription_agreement)
			elsif (params[:payment_method] === 'check')
				investment = create_investment_for_check(investor_entity)
			end
			
			@company = Company.find_by(id: params[:issuer_id])
			respond_to do |format| 
				format.html { render :layout => false}
			end
		rescue FundAmerica::Error => e
			Rails.logger.error "Error: #{e}"
			render json: {:errors => validation_errors}
		end
	end

	def get_subscription_agreement
		subscription_agreement_template_for_offering = FundAmerica::Offering.subscription_agreement_template(params[:offering_id])
		@body_html = subscription_agreement_template_for_offering["draft_content"].html_safe
		respond_to do |format|
				format.html 
		end
	end

private

	def create_offering
		begin
			o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
			entrepreneur_entity_params = {
				:city => "Las Vegas",
				:country => "US",
				:email => "john.entrepreneur@example.com",
				:name => (0...50).map { o[rand(o.length)] }.join,
				:phone => "17025551212",
				:postal_code => "20004",
				:region => "NV",
				:street_address_1 => "555 some st",
				:tax_id_number => "999999999",
				:type => "company",
				:executive_name => "John Johnson",
				:region_formed_in => "NY"
			}
			entrepreneur_entity = FundAmerica::Entity.create(entrepreneur_entity_params)
		rescue FundAmerica::Error => e
			Rails.logger.error "Error: #{e}"
		end
	end

	def get_offering(offering_id)		
		offering = FundAmerica::Offering.details(offering_id)
	end

	def create_investor 
		investor_entity_params = {
			:city => investor_params[:city], # "Las Vegas",
			:country => investor_params[:country], # "US",
			:email => investor_params[:email], # "john.investor@example.com",
			:name => investor_params[:name], # (0...50).map { o[rand(o.length)] }.join,
			:phone => investor_params[:phone], # "17025551212",
			:postal_code => investor_params[:postal_code], # "20004",
			:region => investor_params[:region], # "NV",
			:street_address_1 => investor_params[:street_address_1], # "555 some st",
			:tax_id_number => investor_params[:tax_id_number], # "999999999",
			:type => investor_params[:type], # "company",
			:executive_name => investor_params[:executive_name], # "John Johnson",
			:region_formed_in => investor_params[:region_formed_in], # "NY"				
		}
		investor_entity = FundAmerica::Entity.create(investor_entity_params)		
	end

	def create_subscription_agreement
		subscription_agreement_template_for_offering = FundAmerica::Offering.subscription_agreement_template(params[:offering_id])
		subscription_agreement_params = {
			:equity_share_count => investor_params[:account_share_count],
			:offering_id => params[:offering_id],
			:vesting_amount => params[:amount],
			:vesting_as => investor_params[:name],
			:vesting_as_email => investor_params[:email]			
		}
		subscription_agreement = FundAmerica::SubscriptionAgreement.create(subscription_agreement_params)
	end

	def sing_to_subscription_agreement(subscription_agreement)
		browser = Browser.new("Some User Agent", accept_language: "en-us")		
		if investor_params[:type] === "company"
			electronic_signature_params = {
				:company=> investor_params[:company],
				:email=> investor_params[:email],
				:ip_address=> request.remote_ip,
				:literal=> params[:literal],
				:metadata=> "",
				:name=> investor_params[:name],
				:title=> params[:subscription_agreement_title],
				:user_agent=> browser.name
			}
		elsif investor_params[:type] === "personal"
			electronic_signature_params = {
				:company=> "",
				:email=> investor_params[:email],
				:ip_address=> request.remote_ip,
				:literal=> params[:literal],
				:metadata=> "",
				:name=> investor_params[:name],
				:title=> "",
				:user_agent=> browser.name
			}
		end
		electronic_signature = FundAmerica::ElectronicSignature.update(subscription_agreement["electronic_signatures"][1]["id"], electronic_signature_params)		
	end

	def create_ach_authorization(investor_entity)
		browser = Browser.new("Some User Agent", accept_language: "en-us")
		bank_type = current_user.selected_bank_account[:bank_type]
		account_order = current_user.selected_bank_account[:account_order].to_i
		bank_info = nil
		for bank in current_user.bank_info do 
			if bank[:bank_type] == bank_type
				bank_info = bank
				break
			end
		end		
		account = bank_info[:auth_info].accounts[account_order]
    account_number = account.numbers["account"]
    routing_number = account.numbers["routing"]
    address_info = nil
    if bank_info[:info].info["addresses"].length === 1
    	address_info = bank_info[:info].info["addresses"][0]
    else
    	address_info = bank_info[:info].info["addresses"][account_order]["data"]
		end
		name_on_account = nil
		if bank_info[:info].info["names"].length === 1
    	name_on_account = bank_info[:info].info["names"][0]
    else
    	name_on_account = bank_info[:info].info["names"][account_order]
		end
		account_email = nil
		if bank_info[:info].info["emails"].length === 1
    	account_email = bank_info[:info].info["emails"][0]["data"]
    else
    	account_email = bank_info[:info].info["emails"][account_order]["data"]
		end
		account_type = bank_info[:info].accounts[account_order].subtype
		ach_authorization_params = {
			:account_number => account_number,
			:account_type => account_type,
			:address => address_info["street"],
			:check_type => "personal",
			:city => address_info["city"],
			:email => account_email,
			:entity_id => investor_entity["id"],
			:ip_address => request.remote_ip,
			:literal => params[:literal],
			:name_on_account => name_on_account,
			:routing_number => routing_number,
			:state => address_info["state"],
			:user_agent => browser.name,
			:zip_code => address_info["zip"]
		}
		ach_authorization = FundAmerica::AchAuthorization.create(ach_authorization_params)
	end

	def create_investment_for_ach(investor_entity) 
		ach_authorization = create_ach_authorization(investor_entity)
		investment_params_for_ach = {
			:amount => params[:amount],
			:equity_share_count => investor_params[:account_share_count],
			:offering_id => params[:offering_id],
			:payment_method => "ach",
			:entity_id => investor_entity["id"],
			:ach_authorization_id => ach_authorization["id"]
		}
		investment_for_ach = FundAmerica::Investment.create(investment_params_for_ach)				
	end

	def create_investment_for_wire(investor_entity, subscription_agreement)
		investment_params_for_wire = {
			:amount => params[:amount], #should below than the amount agreed on subscription agreement template
			:equity_share_count => investor_params[:account_share_count],
			:offering_id => params[:offering_id],
			:entity_id => investor_entity["id"],
			:payment_method => "wire",
		}
		investment_for_wire = FundAmerica::Investment.create(investment_params_for_wire)
	end

	def create_investment_for_check(investor_entity)
		investment_params_for_check = {
			:amount => params[:amount], #should below than the amount agreed on subscription agreement template
			:equity_share_count => investor_params[:account_share_count],
			:offering_id => params[:offering_id],
			:entity_id => investor_entity["id"],
			:payment_method => "check"
		}
		investment_for_check = FundAmerica::Investment.create(investment_params_for_check)
	end

	def amount_validation
		offering = get_offering(params[:offering_id])
		amount = params[:amount].to_i
		errors = [];
		if (offering["max_investment_amount"] && amount > offering["max_investment_amount"].to_i)
			errors.push("amount should be smaller than " + offering["max_investment_amount"])
		end
		if (offering["min_investment_amount"] && amount < offering["min_investment_amount"].to_i)
			errors.push("amount should be bigger than " + offering["min_investment_amount"])
		end
		return errors
	end

	def validation_errors
		errors = []
		errors += amount_validation
	end

	def investor_params 
		params.permit(:city, :country, :email, :name, :company, :account_share_count, :phone, :postal_code, :region, :street_address_1, :street_address_2, :tax_id_number, :type, :executive_name, :region_formed_in, :literal)
	end

	def build_whole_structure
		#For further integration
		offering_params = {
			:accredited_investors => "true",
			:amount => "5000000",
			:description => "A really big deal",
			:entity_id => entrepreneur_entity["id"],
			:escrow_closed_at => "2/2/2022",
			:investment_increment_amount => "1000",
			:max_amount => "5500000",
			:max_investment_amount => "25000",
			:min_amount => "4500000",
			:min_investment_amount => "1000",
			:name => (0...50).map { o[rand(o.length)] }.join,
			:non_accredited_investors => "true",
			:non_us_investors => "true",
			:regulatory_exemption => "506c",
			:type => "equity",
			:us_investors => "true"
		}
		offering = FundAmerica::Offering.create(offering_params)
		
		escrow_agreement_params = {
			:offering_id => offering["id"]
		}
		escrow_agreement = FundAmerica::EscrowAgreement.create(escrow_agreement_params)

		#signed agreement
		electronic_signature_params = {
			:company => "John Q LLC",
			:email => "john.entrepreneur@example.com",
			:ip_address => "127.0.0.1",
			:literal => "J Q Entrepreneur",
			:metadata => "",
			:name => investor_entity["name"],
			:title => "El presidente",
			:user_agent => "Some Browser 1.0"
		}
		electronic_signature_for_issuer = FundAmerica::ElectronicSignature.update(escrow_agreement["electronic_signatures"][0]["id"], electronic_signature_params)

		escrow_service_application_params = {
			:escrow_agreement_id => escrow_agreement["id"],
			:ppm_username => "fundamerica",
			:ppm_url => "http://www.example.com/ppm.html",
			:ppm_password => "secret",
			:offering_id => offering["id"]
		}
		escrow_service_application = FundAmerica::EscrowServiceApplication.create(escrow_service_application_params)

		offering = FundAmerica::Offering.update(offering["id"], { :accept_investments => true})

		subscription_agreement_template_params = {
			:draft_content => "%%VESTING_AMOUNT%%%2C+%%VESTING_AS%%%2C+%%VESTING_AS_EMAIL%%%2C+%%EQUITY_SHARE_COUNT%%%2C+%%SUBSCRIBER_SIGNATURE%%%2C+%%ISSUER_SIGNATURE%%",
			:email_document_to_signers => "true",
			:issuer_company => "John LLC",
			:issuer_email => "john.entrepreneur@johnson.com",
			:issuer_literal => "Johnson",
			:issuer_name => "Entrepreneuer",
			:issuer_title => "CEO",
			:offering_id => offering["id"],
			:publish => true
		}
		subscription_agreement_template = FundAmerica::SubscriptionAgreementTemplate.create(subscription_agreement_template_params)

		subscription_agreement_params = {
			:equity_share_count => "2",
			:offering_id => offering["id"],
			:vesting_amount => "2500",
			:vesting_as => investor_entity["name"],
			:vesting_as_email => investor_entity["email"]			
		}
		subscription_agreement = FundAmerica::SubscriptionAgreement.create(subscription_agreement_params)
	end
end


































