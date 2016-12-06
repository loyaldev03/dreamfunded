class Group < ActiveRecord::Base

  has_and_belongs_to_many :users

    has_attached_file :image,
      :styles =>{
        },
      :storage => :s3,
      :bucket => 'dreamfunded',
      :path => "companies/:filename",
      :url =>':s3_domain_url',
      :s3_protocol => :https,
      :s3_credentials => {
        :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
        :secret_access_key => "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"
      }

    has_attached_file :background,
      :styles =>{
        },
      :storage => :s3,
      :bucket => 'dreamfunded',
      :path => "cover-photos/:filename",
      :url =>':s3_domain_url',
      :s3_protocol => :https,
      :s3_credentials => {
        :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
        :secret_access_key => "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"
      }

        validates_attachment_size :background, :less_than => 5.megabytes
        validates_attachment_size :image, :less_than => 5.megabytes
        validates_attachment_content_type :background, content_type: /\Aimage\/.*\z/
        validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
