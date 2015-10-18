# UySA ePay PHP Library.
#	v1.0.2 - April 17th, 2015
#
# 	Copyright (c) 2001-2017 USAePay
#	For assistance please contact devsupport@usaepay.com
#

require 'base64'
require 'uri'
require 'rubygems'
require 'cgi'
require 'net/http'
require 'net/https'
require 'digest/md5'
require 'digest/sha1'

Usaepay_version = "1.0.2"

class UmTransaction
	attr_accessor 	:key,		# Source key
				  	:pin,		# Source pin (optional)
				  	:amount,	# the entire amount that will be charged to the customers card
								# (including tax, shipping, etc)
				  	:invoice,	# invoice number.  must be unique.  limited to 10 digits.  use orderid if you need longer.

					# Required for Commercial Card support

				  	:ponum,		# Purchase Order Number
					:tax,		# Tax
					:nontaxable,	# Order is non taxable

					# Amount details (optional)
					:tip,		# Tip
					:shipping,	# Shipping charge
					:discount,	# Discount amount (ie gift certificate or coupon code)
					:subtotal,	# if subtotal is set, then
								# subtotal + tip + shipping - discount + tax must equal amount
								# or the transaction will be declined.  If subtotal is left blank
								# then it will be ignored
					:currency,	# Currency of $amount
					:allowpartialauth,	# set to true if a partial authorization (less than the full $amount)  will be accepted

					# Required Fields for Card Not Present transacitons (Ecommerce)
					:card,		# card number, no dashes, no spaces
					:exp,		# expiration date 4 digits no /
					:cardholder,	# name of card holder
					:street,	# street address
					:zip,		# zip code

					#	Fields for Card Present (POS)
					:magstripe,	# mag stripe data.  can be either Track 1, Track2  or  Both  (Required if card,exp,cardholder,street and zip aren't filled in)
					:cardpresent,	# Must be set to true if processing a card present transaction  (Default is false)
					:termtype,	# The type of terminal being used:  Optons are  POS - cash register, StandAlone - self service terminal,  Unattended - ie gas pump, Unkown  (Default:  Unknown)
					:magsupport,# Support for mag stripe reader:   yes, no, contactless, unknown  (default is unknown unless magstripe has been sent)
					:contactless,	# Magstripe was read with contactless reader:  yes, no  (default is no)
					:dukpt,		# DUK/PT for PIN Debit
					:signature,	# Signature Capture data

					# fields required for check transactions
					:account,	# bank account number
					:routing,	# bank routing number
					:ssn,		# social security number
					:dlnum,		# drivers license number (required if not using ssn)
					:dlstate,	# drivers license issuing state
					:checknum,	# Check Number
					:accounttype,	# Checking or Savings
					:checkformat,	# Override default check record format
					:checkimage_front,	# Check front
					:checkimage_back,	# Check back
					:auxonus,
					:epccode,
					:ifauthexpired,
					:authexpiredays,
					:inventorylocation,
					:savecard, #create a card token if the sale is approved, returns a cardref variable
					:maskednum,
					:cardtype,
					:transport,
					:clerk,
					:terminal,
					:restaurant_table,
					:cardref,

					# Fields required for Secure Vault Payments (Direct Pay)
					:svpbank,	# ID of cardholders bank
					:svpreturnurl,	# URL that the bank should return the user to when tran is completed
					:svpcancelurl,	# URL that the bank should return the user if they cancel


					# Option parameters
					:origauthcode,	# required if running postauth transaction.
					:command,	# type of command to run, Possible values are:
								# sale, credit, void, preauth, postauth, check and checkcredit.
								# Default is sale.
					:orderid,	# Unique order identifier.  This field can be used to reference
								# the order for which this transaction corresponds to. This field
								# can contain up to 64 characters and should be used instead of
								# UMinvoice when orderids longer that 10 digits are needed.
					:custid,	# Alpha-numeric id that uniquely identifies the customer.
					:description,	# description of charge
					:cvv2,		# cvv2 code
					:custemail,	# customers email address
					:custreceipt,	# send customer a receipt
					:custreceiptname,	# name of custom receipt template
					:ignoreduplicate,	# prevent the system from detecting and folding duplicates
					:ip,		# ip address of remote host
					:testmode,	# test transaction but don't process it
					:usesandbox,# use sandbox server instead of production
					:timeout,	# transaction timeout.  defaults to 45 seconds
					:gatewayurl,# url for the gateway
					:proxyurl,	# proxy server to use (if required by network)

					# Card Authorization - Verified By Visa and Mastercard SecureCode
					:cardauth,	# enable card authentication
					:pares,		#

					# Third Party Card Authorization
					:xid,
					:cavv,
					:eci,

					# Customer Database
					:addcustomer,	# Save transaction as a recurring transaction:  yes/no
					:recurring,		# (obsolete,  see the addcustomer)

					:schedule,		#  How often to run transaction: daily, weekly, biweekly, monthly, bimonthly, quarterly, annually.  Default is monthly, set to disabled if you don't want recurring billing
					:numleft, 		#  The number of times to run. Either a number or * for unlimited.  Default is unlimited.
					:start,			#  When to start the schedule.  Default is tomorrow.  Must be in YYYYMMDD  format.
					:end,			#  When to stop running transactions. Default is to run forever.  If both end and numleft are specified, transaction will stop when the earliest condition is met.
					:billamount,	#  Optional recurring billing amount.  If not specified, the amount field will be used for future recurring billing payments
					:billtax,
					:billsourcekey,

					# Billing Fields
					:billfname,:billlname,:billcompany,:billstreet,:billstreet2,:billcity,:billstate,:billzip,:billcountry,:billphone,:email,:fax,:website,

					# Shipping Fields
					:delivery,		# type of delivery method ('ship','pickup','download')
					:shipfname,:shiplname,:shipcompany,:shipstreet,:shipstreet2,:shipcity,:shipstate,:shipzip,:shipcountry,:shipphone,

					# Custom Fields
					:custom1,:custom2,:custom3,:custom4,:custom5,:custom6,:custom7,:custom8,:custom9,:custom10,:custom11,:custom12,:custom13,:custom14,:custom15,:custom16,:custom17,:custom18,:custom19,:custom20,


					# Line items  (see addLine)
					:lineitems,


					:comments, 		# Additional transaction details or comments (free form text field supports up to 65,000 chars)

					:software, 		# Allows developers to identify their application to the gateway (for troubleshooting purposes)


					# response fields
					:rawresult,		# raw result from gateway
					:result,		# full result:  Approved, Declined, Error
					:resultcode, 	# abreviated result code: A D E
					:authcode,		# authorization code
					:refnum,		# reference number
					:batch,			# batch number
					:avs_result,	# avs result
					:avs_result_code,	# avs result
					:avs,  			# obsolete avs result
					:cvv2_result,	# cvv2 result
					:cvv2_result_code,	# cvv2 result
					:vpas_result_code,  # vpas result
					:isduplicate,      	# system identified transaction as a duplicate
					:convertedamount,  	# transaction amount after server has converted it to merchants currency
					:convertedamountcurrency,  # merchants currency
					:conversionrate,	# the conversion rate that was used
					:custnum,  		# gateway assigned customer ref number for recurring billing
					:authamount, 	# amount that was authorized
					:balance,  		#remaining balance
					:cardlevelresult,
					:procrefnum,

					# Cardinal Response Fields
					:acsurl,	# card auth url
					:pareq,		# card auth request
					:cctransid, # cardinal transid


					# Errors Response Feilds
					:error, 		# error message if result is an error
					:errorcode, 	# numerical error code
					:blank,			# blank response
					:transporterror


					def initialize
						@command="sale"
						@result="Error"
						@resultcode="E"
						@error="Transaction not processed yet."
 						@timeout=45
						@cardpresent=false
						@lineitems = Array.new
						#@ip=ENV["REMOTE_ADDR"]
						@software="USAePay RUBY API v. #{Usaepay_version}"
					end

					def addLine (sku, name, description, cost, qty, taxable, taxrate, taxamount, um, commoditycode, discountrate, discountamount, taxclass)
						@lineitems << {
						'sku' => sku,
						'name' => name,
						'description' => description,
						'cost' => cost,
						'taxable' => taxable,
						'taxrate' => taxrate,
						'taxamount' => taxamount,
						'um' => um,
						'qty' => qty,
						'commoditycode' => commoditycode,
						'discountrate' => discountrate,
						'discountamount' => discountamount,
						'taxclass' => taxclass,

						}
					end

					def clearLines
						@lineitems=Array.new
					end

					def clearData
						$map=self.getFieldMap
						$map.each do |apifield , classfield|
							$classfield=Object.nil if (classfield=='software'  || classfield=='key' || classfield=='pin')
						end

						# Set default values.
						@command="sale"
						@result="Error"
						@resultcode="E"
						@error="Transaction not processed yet."
						@cardpresent=false
						@lineitems = Array.new
						#if(isset($_SERVER['REMOTE_ADDR'])) $this->ip=$_SERVER['REMOTE_ADDR'];

					end


	 				# Verify that all required data has been set
	 				# @return string

					def checkData
						return "Source Key is required" if !@key
						command_array = ["cc:capture", "cc:refund", "refund", "check:refund","capture", "creditvoid", "quicksale", "quickcredit","void:release","cc:save"]
						if command_array.include?(@command.downcase)
						then
							return "Reference Number is required" if !@refnum
					 	else if @command.downcase == "svp"
					 			then
									return "Bank ID is required" if !@svpbank
									return "Return URL is required"	if !@svpreturnurl
									return "Cancel URL is required"	if !@svpcancelurl
								else
								cammand_array = ["check:sale","check:credit", "check", "checkcredit","reverseach"]
								if(command_array.include?(@command.downcase))
									then
										return "Account Number is required" if !@account
										return "Routing Number is required" if !@routing
									else if !@magstripe
										then
												return "Credit Card Number is required (#{@command})" if !@card
												return "Expiration Date is required" if !@exp
										end
								end
							end

						@amount=@amount.sub(/^\D/,'')
						return "Amount is required" if !@amount
			 			return "Invoice number or Order ID is required" if !@invoice && !@orderid
					 	end
					end


	 				# Send transaction to the USAePay Gateway and parse response
	 				# @return boolean

					def Test
						# VERSION
						min_ver = '1.8.0'
						s= RUBY_VERSION.dup
						unless Gem::Version.new(min_ver) <= Gem::Version.new(s)
						    puts '<font color="red">Ruby version too old</font>'+ "<br>Current Version of Ruby is #{RUBY_VERSION}. Pleaese upgrade to version greater or equal then #{min_ver}"
						end

						software_raw_url = URI.escape(@software, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
						test_gateway=(@gatewayurl?@gatewayurl:"https://www.usaepay.com/secure/gate.php") + "?VersionCheck=1&UMsoftware=" +software_raw_url;

						puts test_gateway
						result=self.httpGet(test_gateway);
						return false if result===false

						# result is in urlencoded format, parse into an array
						tmp=CGI::parse(result)

						# check to make sure we received the correct fields
						if tmp["UMversion"].nil? || tmp["UMstatus"].nil?
						    puts '<font color="red">Cannot connect to gateway</font>'
						else
						    puts '<font color="green">Ok</font><br>
						    Successfully connected to the gateway. Detected version '+ tmp["UMversion"][0] +' of the USAePay gateway API.'
                  end


                  require "openssl"
                  puts OpenSSL::OPENSSL_VERSION
                  puts "DEFAULT_SSL_CERT_FILE: %s" % OpenSSL::X509::DEFAULT_CERT_FILE
                  puts "DEFAULT_SSL_CERT_DIR: %s" % OpenSSL::X509::DEFAULT_CERT_DIR




					end

					def getLineTotal
					    $total = 0
					    if !@lineitems.kind_of?(Array) then @lineitems=Array.new end
					    @lineitems.each do |lineitem|
							$total += (Integer(lineitem['cost']*100) * Integer(lineitem['qty']))
					    end
					    return "%.2f" % ($total / 100.00)
					end


					def httpGet(url)
					(proxy_proto,proxy_line) = @proxyurl.split('://') unless @proxyurl.nil?
					(proxy_addr, proxy_port) = proxy_line.split(':') unless proxy_line.nil?

					proxy_addr = nil if proxy_port.nil?
    					    url=URI.parse(url)

							Net::HTTP.start(url.host, url.port) do |http|
							http = Net::HTTP.new(url.host, url.port, proxy_addr, proxy_port)
							http.use_ssl = true if url.scheme == 'https'
							req = Net::HTTP::Get.new(url.path)
							response = http.request(req)
							@transporterror = response.code + ' '+ response.message
							return response.body

						end
					end

					def process

						# check that we have the needed data
						$tmp=self.checkData
						$tmp
						if $tmp==false
						then
							@result="Error"
							@resultcode="E"
							@error=$tmp
							@errorcode=10129
							return false
						end

						# populate the data
						$map = self.getFieldMap
						$data = Hash.new
						$map.each do |apifield, classfield|
							case classfield
								when 'nontaxable' then
									$data['UMnontaxable'] = 'Y' if @nontaxable
								when 'checkimage_front' then
								when 'checkimage_back' then
									$data[apifield] = Base64.encode64(classfield)
								when 'billsourcekey' then
									$data['UMbillsourcekey'] = 'yes' if @billsourcekey
								when 'cardpresent' then
									$data['UMcardpresent'] = '1' if @cardpresent
								when 'allowpartialauth' then
									$data['UMallowPartialAuth'] = 'Yes' if @allowpartialauth==true
								when 'savecard' then
									$data['UMsaveCard'] = 'y' if @savecard == true
								else
									$data.keys.push(apifield)
									$data[apifield]=classfield
							end
						end

						$data['UMcheckimageencoding'] = 'base64' if $data['UMcheckimagefront'].nil? || $data['UMcheckimageback'].nil?

						# tack on custom fields
						1.upto(20) do |i|
							$data["UMcustom#{i}"] = instance_variable_get("@custom#{i}") if !instance_variable_get("@custom#{i}").nil?
						end

						#tack on line level detail
						c=1
						if !@lineitems.kind_of?(Array) then @lineitems=Array.new end
						@lineitems.each do |lineitem|
							$data["UMline#{c}sku"] = lineitem['sku']
							$data["UMline#{c}name"] = lineitem['name']
							$data["UMline#{c}description"] = lineitem['description']
							$data["UMline#{c}cost"] = lineitem['cost']
							$data["UMline#{c}taxable"] = lineitem['taxable']
							$data["UMline#{c}qty"] = lineitem['qty']
							$data["UMline#{c}taxrate"] = lineitem['taxrate']
							$data["UMline#{c}taxamount"] = lineitem['taxamount']
							$data["UMline#{c}um"] = lineitem['um']
							$data["UMline#{c}commoditycode"] = lineitem['commoditycode']
							$data["UMline#{c}discountrate"] = lineitem['discountrate']
							$data["UMline#{c}discountamount"] = lineitem['discountamount']
							$data["UMline#{c}taxclass"] = lineitem['taxclass']
							c+=1
						end

						# Create hash if pin has been set.
						if @pin.to_s.strip then

						# generate random seed value
						t=Time.now
						seed = "#{t.year}#{t.month}#{t.day}#{t.hour}#{rand(1000)}"

						# assemble prehash data
						prehash = "#{@command}:#{@pin.to_s.strip}:#{@amount}:#{@invoice}:#{seed}"

						# if sha1 is available,  create sha1 hash,  else use md5
						hash = "s/#{seed}/#{Digest::SHA1.hexdigest(prehash)}/n"

						# populate hash value
						$data['UMhash'] = hash
						end

						# Figure out URL
						url = ( @gatewayurl==true ? gatewayurl : "https://www.usaepay.com/gate")
						url = "https://sandbox.usaepay.com/gate" if @usesandbox

						# Post data to Gateway
						result=self.httpPost(url, $data)
						return false if result===false

						# result is in urlencoded format, parse into an array
                  tmp=CGI::parse(result)
                  tmp.each do |key,value|
                     tmp[key] = value[0] unless value.size>1
                  end
						# check to make sure we received the correct fields
						if tmp["UMversion"].nil? || tmp["UMstatus"].nil?
						then
							@result="Error"
							@resultcode="E"
							@error="Error parsing data from card processing gateway."
							@errorcode=10132
							return false
						end
						# Store results
						@result=(tmp["UMstatus"]?tmp["UMstatus"]:"Error")
						@resultcode=(tmp["UMresult"]?tmp["UMresult"]:"E")
						@authcode=(tmp["UMauthCode"]?tmp["UMauthCode"]:"")
						@refnum=(tmp["UMrefNum"]?tmp["UMrefNum"]:"")
						@batch=(tmp["UMbatch"]?tmp["UMbatch"]:"")
						@avs_result=(tmp["UMavsResult"]?tmp["UMavsResult"]:"")
						@avs_result_code=(tmp["UMavsResultCode"]?tmp["UMavsResultCode"]:"")
						@cvv2_result=(tmp["UMcvv2Result"]?tmp["UMcvv2Result"]:"")
						@cvv2_result_code=(tmp["UMcvv2ResultCode"]?tmp["UMcvv2ResultCode"]:"")
						@vpas_result_code=(tmp["UMvpasResultCode"]?tmp["UMvpasResultCode"]:"")
						@convertedamount=(tmp["UMconvertedAmount"]?tmp["UMconvertedAmount"]:"")
						@convertedamountcurrency=(tmp["UMconvertedAmountCurrency"]?tmp["UMconvertedAmountCurrency"]:"")
						@conversionrate=(tmp["UMconversionRate"]?tmp["UMconversionRate"]:"")
						@error=(tmp["UMerror"]?tmp["UMerror"]:"")
						@errorcode=(tmp["UMerrorcode"]?tmp["UMerrorcode"]:"10132")
						@custnum=(tmp["UMcustnum"]?tmp["UMcustnum"]:"")
						@authamount=(tmp["UMauthAmount"]?tmp["UMauthAmount"]:"")
						@balance=(tmp["UMremainingBalance"]?tmp["UMremainingBalance"]:"")
						@cardlevelresult=(tmp["UMcardLevelResult"]?tmp["UMcardLevelResult"]:"")
						@procrefnum=(tmp["UMprocRefNum"]?tmp["UMprocRefNum"]:"")
						@cardref=(tmp["UMcardRef"]?tmp["UMcardRef"]:"")
						@cardtype=(tmp["UMcardType"]?tmp["UMcardType"]:"")
						@maskednum=(tmp["UMmaskedCardNum"]?tmp["UMmaskedCardNum"]:"")


						# Obsolete variable (for backward compatibility) At some point they will no longer be set.
						@avs=(tmp["UMavsResult"]?tmp["UMavsResult"]:"")
						@cvv2=(tmp["UMcvv2Result"]?tmp["UMcvv2Result"]:"")
						@timeout=(tmp["UMtimeout"]?tmp["UMtimeout"]:"")
						@cctransid=tmp["UMcctransid"] if tmp["UMcctransid"]
					 	@acsurl=tmp["UMacsurl"] if tmp["UMacsurl"]
		 				@pareq=tmp["UMpayload"] if tmp["UMpayload"]
						(@resultcode == "A")?true:false

					end

					def xmlentities(string)
						string = string.gsub(/[^a-zA-Z0-9_\-\.]/) {|num| _uePhpLibPrivateXMLEntities(num)}
						return string
					end

					def processQuickSale

					# check that we have the needed data
					@command="quicksale"

					$tmp=self.checkData
					if $tmp
					then
						@result="Error"
						@resultcode="E";
						@error=$tmp
						@errorcode=10129
						return false
					end

					# Create hash if pin has been set.
					if(!@pin.to_s.strip)
						then
							@result="Error"
							@resultcode="E"
							@error='Source key must have pin assigned to run transaction'
							@errorcode=999
							return false
						end

						# generate random seed value
						t=Time.now
						seed = "#{t.year}#{t.month}#{t.day}#{t.hour}#{rand(1000)}"

						# assemble prehash data
						prehash = "#{@key}#{seed}#{@pin.to_s.strip}"

						# if sha1 is available,  create sha1 hash,  else use md5
						hash = Digest::SHA1.hexdigest(prehash)


						$data = '<?xml version="1.0" encoding="UTF-8"?>' +
							'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:usaepay" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
							'<SOAP-ENV:Body>' +
							'<ns1:runQuickSale>' +
							'<Token xsi:type="ns1:ueSecurityToken">' +
						#	'<ClientIP xsi:type="xsd:string">' + @ip + '</ClientIP>' +
							'<PinHash xsi:type="ns1:ueHash">' +
							'<HashValue xsi:type="xsd:string">' + hash + '</HashValue>' +
							'<Seed xsi:type="xsd:string">' + seed + '</Seed>' +
							'<Type xsi:type="xsd:string">sha1</Type>' +
							'</PinHash>' +
							'<SourceKey xsi:type="xsd:string">' + @key + '</SourceKey>' +
							'</Token>' +
							'<RefNum xsi:type="xsd:integer">' + @refnum.gsub(/\D/,'') + '</RefNum>' +
							'<Details xsi:type="ns1:TransactionDetail">' +
							'<Amount xsi:type="xsd:double">' + self.xmlentities(@amount) + '</Amount>' +
							'<Description xsi:type="xsd:string">' + self.xmlentities(@description.to_s) + '</Description>'+
							'<Discount xsi:type="xsd:double">' + self.xmlentities(@discount.to_s) + '</Discount>' +
							'<Invoice xsi:type="xsd:string">' + self.xmlentities(@invoice.to_s) + '</Invoice>' +
				    		'<NonTax xsi:type="xsd:boolean">' + (@nontaxable ? 'true' : 'false' ) + '</NonTax>' +
							'<OrderID xsi:type="xsd:string">' + self.xmlentities(@orderid.to_s) + '</OrderID>' +
							'<PONum xsi:type="xsd:string">' + self.xmlentities(@ponum.to_s) + '</PONum>' +
							'<Shipping xsi:type="xsd:double">' + self.xmlentities(@shipping.to_s) + '</Shipping>' +
							'<Subtotal xsi:type="xsd:double">' + self.xmlentities(@subtotal.to_s) + '</Subtotal>' +
							'<Tax xsi:type="xsd:double">' + self.xmlentities(@tax.to_s) + '</Tax>' +
							'<Tip xsi:type="xsd:double">' + self.xmlentities(@tip.to_s) + '</Tip>' +
							'</Details>' +
							'<AuthOnly xsi:type="xsd:boolean">false</AuthOnly>' +
							'</ns1:runQuickSale>' +
							'</SOAP-ENV:Body>' +
							'</SOAP-ENV:Envelope>'

							# Figure out URL
							url = (@gatewayurl?@gatewayurl:"https://www.usaepay.com/soap/gate/15E7FB61")
							url = "https://sandbox.usaepay.com/soap/gate/15E7FB61" if @usesandbox

							# Post data to Gateway
							result=self.httpPost(url, {'xml'=>$data})
							return false if result===false

							m = result.scan(/<AuthCode[^>]*>(.*)<\/AuthCode>/); @authcode = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<AvsResult[^>]*>(.*)<\/AvsResult>/); @avs_result = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<AvsResultCode[^>]*>(.*)<\/AvsResultCode>/); @avs_result_code = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<BatchRefNum[^>]*>(.*)<\/BetchRefNum>/); @batch = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<CardCodeResult[^>]*>(.*)<\/CardCodeResult>/); @cvv2_result = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<CardCodeResultCode[^>]*>(.*)<\/CardCodeResultCode>/); @cvv2_result_code = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ConversionRate[^>]*>(.*)<\/ConversionRate>/); @conversionrate = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ConvertedAmount[^>]*>(.*)<\/ConvertedAmount>/); @convertedamount = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ConvertedAmountCurrency[^>]*>(.*)<\/ConvertedAmountCurrency>/); @convertedamountcurrency = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<Error[^>]*>(.*)<\/Error>/); @error = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ErrorCode[^>]*>(.*)<\/ErrorCode>/); @errorcode = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<RefNum[^>]*>(.*)<\/RefNum>/); @refnum = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<Result[^>]*>(.*)<\/Result>/); @result = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ResultCode[^>]*>(.*)<\/ResultCode>/); @resultcode = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<VpasResultcode[^>]*>(.*)<\/VpasResultCode>/); @vpas_result_code = m[0][0].to_s if !m.empty? && !m[0].empty?


							# Store results
							return true if @resultcode == "A"
							return false
					end

					def processQuickCredit

					# check that we have the needed data
					@command="quickcredit"

					$tmp=self.checkData
					if $tmp
					then
						@result="Error"
						@resultcode="E";
						@error=$tmp
						@errorcode=10129
						return false
					end

					# Create hash if pin has been set.
					if(!@pin.to_s.strip)
						then
							@result="Error"
							@resultcode="E"
							@error='Source key must have pin assigned to run transaction'
							@errorcode=999
							return false
						end

						# generate random seed value
						t=Time.now
						seed = "#{t.year}#{t.month}#{t.day}#{t.hour}#{rand(1000)}"

						# assemble prehash data
						prehash = "#{@key}#{seed}#{@pin.to_s.strip}"

						# if sha1 is available,  create sha1 hash,  else use md5
						hash = Digest::SHA1.hexdigest(prehash)


						$data = '<?xml version="1.0" encoding="UTF-8"?>' +
							'<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:usaepay" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
							'<SOAP-ENV:Body>' +
							'<ns1:runQuickCredit>' +
							'<Token xsi:type="ns1:ueSecurityToken">' +
						#	'<ClientIP xsi:type="xsd:string">' + @ip + '</ClientIP>' +
							'<PinHash xsi:type="ns1:ueHash">' +
							'<HashValue xsi:type="xsd:string">' + hash + '</HashValue>' +
							'<Seed xsi:type="xsd:string">' + seed + '</Seed>' +
							'<Type xsi:type="xsd:string">sha1</Type>' +
							'</PinHash>' +
							'<SourceKey xsi:type="xsd:string">' + @key + '</SourceKey>' +
							'</Token>' +
							'<RefNum xsi:type="xsd:integer">' + @refnum.gsub(/\D/,'') + '</RefNum>' +
							'<Details xsi:type="ns1:TransactionDetail">' +
							'<Amount xsi:type="xsd:double">' + self.xmlentities(@amount) + '</Amount>' +
							'<Description xsi:type="xsd:string">' + self.xmlentities(@description.to_s) + '</Description>'+
							'<Discount xsi:type="xsd:double">' + self.xmlentities(@discount.to_s) + '</Discount>' +
							'<Invoice xsi:type="xsd:string">' + self.xmlentities(@invoice.to_s) + '</Invoice>' +
				    		'<NonTax xsi:type="xsd:boolean">' + (@nontaxable ? 'true' : 'false' ) + '</NonTax>' +
							'<OrderID xsi:type="xsd:string">' + self.xmlentities(@orderid.to_s) + '</OrderID>' +
							'<PONum xsi:type="xsd:string">' + self.xmlentities(@ponum.to_s) + '</PONum>' +
							'<Shipping xsi:type="xsd:double">' + self.xmlentities(@shipping.to_s) + '</Shipping>' +
							'<Subtotal xsi:type="xsd:double">' + self.xmlentities(@subtotal.to_s) + '</Subtotal>' +
							'<Tax xsi:type="xsd:double">' + self.xmlentities(@tax.to_s) + '</Tax>' +
							'<Tip xsi:type="xsd:double">' + self.xmlentities(@tip.to_s) + '</Tip>' +
							'</Details>' +
							'<AuthOnly xsi:type="xsd:boolean">false</AuthOnly>' +
							'</ns1:runQuickCredit>' +
							'</SOAP-ENV:Body>' +
							'</SOAP-ENV:Envelope>'

							# Figure out URL
							url = (@gatewayurl?@gatewayurl:"https://www.usaepay.com/soap/gate/15E7FB61")
							url = "https://sandbox.usaepay.com/soap/gate/15E7FB61" if @usesandbox

							# Post data to Gateway
							result=self.httpPost(url, {'xml'=>$data})
							return false if result===false

							m = result.scan(/<AuthCode[^>]*>(.*)<\/AuthCode>/); @authcode = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<AvsResult[^>]*>(.*)<\/AvsResult>/); @avs_result = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<AvsResultCode[^>]*>(.*)<\/AvsResultCode>/); @avs_result_code = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<BatchRefNum[^>]*>(.*)<\/BetchRefNum>/); @batch = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<CardCodeResult[^>]*>(.*)<\/CardCodeResult>/); @cvv2_result = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<CardCodeResultCode[^>]*>(.*)<\/CardCodeResultCode>/); @cvv2_result_code = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ConversionRate[^>]*>(.*)<\/ConversionRate>/); @conversionrate = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ConvertedAmount[^>]*>(.*)<\/ConvertedAmount>/); @convertedamount = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ConvertedAmountCurrency[^>]*>(.*)<\/ConvertedAmountCurrency>/); @convertedamountcurrency = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<Error[^>]*>(.*)<\/Error>/); @error = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ErrorCode[^>]*>(.*)<\/ErrorCode>/); @errorcode = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<RefNum[^>]*>(.*)<\/RefNum>/); @refnum = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<Result[^>]*>(.*)<\/Result>/); @result = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<ResultCode[^>]*>(.*)<\/ResultCode>/); @resultcode = m[0][0].to_s if !m.empty? && !m[0].empty?
							m = result.scan(/<VpasResultcode[^>]*>(.*)<\/VpasResultCode>/); @vpas_result_code = m[0][0].to_s if !m.empty? && !m[0].empty?


							# Store results
							return true if @resultcode == "A"
							return false
					end


					def getFieldMap

						array = {
						'UMkey' => @key,
						'UMcommand' => @command,
						'UMauthCode' => @origauthcode,
						'UMcard' => @card,
						'UMexpir' => @exp,
						'UMbillamount' => @billamount,
						'UMamount' => @amount,
						'UMinvoice' => @invoice,
						'UMorderid' => @orderid,
						'UMponum' => @ponum,
						'UMtax' => @tax,
						'UMnontaxable' => @nontaxable,
						'UMtip' => @tip,
						'UMshipping' => @shipping,
						'UMdiscount' => @discount,
						'UMsubtotal' => @subtotal,
						'UMcurrency' => @currency,
						'UMname' => @cardholder,
						'UMstreet' => @street,
						'UMzip' => @zip,
						'UMdescription' => @description,
						'UMcomments' => @comments,
						'UMcvv2' => @cvv2,
						'UMip' => @ip,
						'UMtestmode' => @testmode,
						'UMcustemail' => @custemail,
						'UMcustreceipt' => @custreceipt,
						'UMrouting' => @routing,
						'UMaccount' => @account,
						'UMssn' => @ssn,
						'UMdlstate' => @dlstate,
						'UMdlnum' => @dlnum,
						'UMchecknum' => @checknum,
						'UMaccounttype' => @accounttype,
						'UMcheckformat' => @checkformat,
						'UMcheckimagefront' => @checkimage_front,
						'UMcheckimageback' => @checkimage_back,
						'UMaddcustomer' => @addcustomer,
						'UMrecurring' => @recurring,
						'UMbilltax' => @billtax,
						'UMschedule' => @schedule,
						'UMnumleft' => @numleft,
						'UMstart' => @start,
						'UMexpire' => @end,
						'UMbillsourcekey' => @billsourcekey,
						'UMbillfname' => @billfname,
						'UMbilllname' => @billlname,
						'UMbillcompany' => @billcompany,
						'UMbillstreet' => @billstreet,
						'UMbillstreet2' => @billstreet2,
						'UMbillcity' => @billcity,
						'UMbillstate' => @billstate,
						'UMbillzip' => @billzip,
						'UMbillcountry' => @billcountry,
						'UMbillphone' => @billphone,
						'UMemail' => @email,
						'UMfax' => @fax,
						'UMwebsite' => @website,
						'UMshipfname' => @shipfname,
						'UMshiplname' => @shiplname,
						'UMshipcompany' => @shipcompany,
						'UMshipstreet' => @shipstreet,
						'UMshipstreet2' => @shipstreet2,
						'UMshipcity' => @shipcity,
						'UMshipstate' => @shipstate,
						'UMshipzip' => @shipzip,
						'UMshipcountry' => @shipcountry,
						'UMshipphone' => @shipphone,
						'UMcardauth' => @cardauth,
						'UMpares' => @pares,
						'UMxid' => @xid,
						'UMcavv' => @cavv,
						'UMeci' => @eci,
						'UMcustid' => @custid,
						'UMcardpresent' => @cardpresent,
						'UMmagstripe' => @magstripe,
						'UMdukpt' => @dukpt,
						'UMtermtype' => @termtype,
						'UMmagsupport' => @magsupport,
						'UMcontactless' => @contactless,
						'UMsignature' => @signature,
						'UMsoftware' => @software,
						'UMignoreDuplicate' => @ignoreduplicate,
						'UMrefNum' => @refnum,
						'UMauxonus' => @auxonus,
						'UMepcCode' => @epccode,

						'UMclerk' => @clerk,
						'UMtranterm' => @terminal,
						'UMresttable' => @restaurant_table,
						'UMtimeout' => @timeout,
	    	    		'UMifAuthExpired' => @ifauthexpired,
						'UMauthExpireDays' => @authexpiredays,
						'UMinventorylocation' => @inventorylocation,
						'UMsaveCard' => @savecard,

						'UMcustreceiptname' => @custreceiptname,
						'UMallowPartialAuth' => @allowpartialauth
						}
					return array
					end

					def httpPost(url, data)
					soapcall=false;
					(proxy_proto,proxy_line) = @proxyurl.split('://') unless @proxyurl.nil?
					(proxy_addr, proxy_port) = proxy_line.split(':') unless proxy_line.nil?

					proxy_addr = nil if proxy_port.nil?

					if data.class==Hash
						then
						soapcall=true if data.include?("xml")
						end

					if soapcall
						then
								data=data['xml']
								url=URI.parse(url)

								Net::HTTP.start(url.host, url.port) do |http|
									http = Net::HTTP.new(url.host, url.port, proxy_addr, proxy_port )
									http.use_ssl = true if url.scheme == 'https'
									req = Net::HTTP::Post.new(url.path)
									req.content_type = 'text/xml'
									req.body=data
									response = http.request(req)
									@transporterror = response.code + ' '+ response.message
									return response.body
								end

						else
							url=URI.parse(url)

							Net::HTTP.start(url.host, url.port) do |http|
							http = Net::HTTP.new(url.host, url.port, proxy_addr, proxy_port)
							http.use_ssl = true if url.scheme == 'https'
							req = Net::HTTP::Post.new(url.path)
							req.set_form_data(data)
							response = http.request(req)
							@transporterror = response.code + ' '+ response.message
							return response.body

						end
					end



					def _uePhpLibPrivateXMLEntities(num)
						chars = {128 => '&#8364;',130 => '&#8218;',131 => '&#402;', 132 => '&#8222;', 133 => '&#8230;', 134 => '&#8224;', 135 => '&#8225;', 136 => '&#710;', 137 => '&#8240;', 138 => '&#352;', 139 => '&#8249;', 140 => '&#338;', 142 => '&#381;', 145 => '&#8216;',146 => '&#8217;',147 => '&#8220;',148 => '&#8221;',149 => '&#8226;',150 => '&#8211;',151 => '&#8212;',152 => '&#732;', 153 => '&#8482;',154 => '&#353;', 155 => '&#8250;',156 => '&#339;', 158 => '&#382;', 159 => '&#376;'}
						num = num[0]
						return ((num > 127 && num < 160) ? chars[num] : "&#"+num.to_s+";" )
					end

end

end
