class PaymentController < ApplicationController
	require 'usaepayDriver'
	
	def index
		@client=UeSoapServerPortType.new

	end

	# Create security token
	require 'digest'

	def getToken(key,pin)
		token=UeSecurityToken.new
		token.clientIP = "123.123.123.123"
		hash=UeHash.new
		t=Time.now
		seed = "#{t.year}#{t.month}#{t.day}#{t.hour}#{rand(1000)}" 
		prehash = "#{key}#{seed}#{pin.to_s.strip}" 
		hash.seed=seed 
		hash.type="sha1" 
		hash.hashValue=Digest::SHA1.hexdigest(prehash).to_s 
		token.pinHash = hash 
		token.sourceKey=key 
		return token
	end

	

end
