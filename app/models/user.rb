class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	has_many :investments
	has_many :companies
	has_many :comments

	has_many :invites

	has_many :liquidate_shares
	has_many :bids

	has_one :investor

	has_many :docusigns
	#Getter
	validates :first_name, presence:true
	validates :last_name, presence:true
	#validates_uniqueness_of :login
	validates_uniqueness_of :email
	#validates :password, length: { in: 6..20 }
	validates :password, confirmation: true

	def self.from_omniauth(auth)
		pass =  SecureRandom.uuid.gsub(/\-/, '')
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.email = auth.info.email
	    user.confirmed = true
	    user.first_name = auth.info.name.split(' ').first
	    user.last_name = auth.info.name.split(' ').second
	    user.authority = 1
	    #user.image_url = auth.info.image
	  end
	end

	# def password_valid?(pass)
	# 	pass_db = self.password_digest
	# 	salt = self.salt
	# 	result = pass + salt.to_s
	# 	pass_candidate = Digest::SHA1.hexdigest(result)
	# 	return(pass_candidate == pass_db)
	# end

	# def password
	# 	return @password
	# end

	# def password=(pass)
	# 	@password = pass
	# 	salt = rand
	# 	self.salt = salt
	# 	result = pass + salt.to_s
	# 	self.password_digest = Digest::SHA1.hexdigest(result)
	# end

	def self.Authority
		{
			:Basic => 1,
			:Accredited => 2,
			:Founder => 3,
			:Admin => 4
		}
	end

	def name
		first_name.capitalize + " " + last_name.capitalize
	end

	def comments_name
		first_name.capitalize + " " + last_name.capitalize.chars.first + "."
	end

end
