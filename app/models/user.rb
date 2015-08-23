class User < ActiveRecord::Base
	has_many :company
	#Getter
	validates :first_name, presence:true
	validates :last_name, presence:true
	validates_uniqueness_of :login
	validates :password, length: { in: 6..20 }
	validates :password, confirmation: true

	def password_valid?(pass)
		pass_db = self.password_digest
		salt = self.salt
		result = pass + salt.to_s
		pass_candidate = Digest::SHA1.hexdigest(result)
		return(pass_candidate == pass_db)
	end

	def password
		return @password
	end

	def password=(pass)
		@password = pass
		salt = rand
		self.salt = salt
		result = pass + salt.to_s
		self.password_digest = Digest::SHA1.hexdigest(result)
	end

	def self.Authority
		{
			:Basic => 1,
			:Accredited => 2,
			:Founder => 3,
			:Admin => 4
		}
	end

end
