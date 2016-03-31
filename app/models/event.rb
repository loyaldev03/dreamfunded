class Event < ActiveRecord::Base
   has_attached_file :image,
     :styles =>{
        medium: "300x300>",
        small: "200x200>",
        thumb: "100x100>"
      },
     :storage => :s3,
     :bucket => 'dreamfunded',
     :path => "events/:filename",
     :url =>':s3_domain_url',
     :s3_protocol => :https,
     :s3_credentials => {
       :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
       :secret_access_key => "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"
     }

    validates_attachment_size :image, :less_than => 5.megabytes
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
