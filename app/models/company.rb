class Company < ActiveRecord::Base
	belongs_to :user

	has_many :sections
	has_many :founders
	has_many :documents

	has_attached_file :image,
	  :styles =>{
	    },
	  :storage => :s3,
	  :bucket => 'dreamfunded',
	  :path => "companies/:filename",
	  :url =>':s3_domain_url',
	  :s3_credentials => {
	    :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
	    :secret_access_key => "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"
	  }
  has_attached_file :document,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }

	# validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 5.megabytes
	validates :user_id, presence:true
	validates :name, presence:true
	validates_uniqueness_of :name
	validates :description, presence:true
	validates :invested_amount, presence:true
	validates :goal_amount, presence:true
	validates :status, presence:true
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	validates_attachment_content_type :document, :content_type =>['application/pdf']

	def self.Status
		{
			:Coming_Soon => 1,
			:Active => 2,
			:Funded => 3,
		}
	end

	def get_status
		if self.status == 1
			"Coming Soon"
		elsif self.status == 2
			"Active"
		elsif self.status == 3
			"Funded"
		end
	end
end
