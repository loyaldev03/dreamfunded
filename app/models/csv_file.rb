class CsvFile < ActiveRecord::Base
    belongs_to :user
    #before_save :set_token

    has_attached_file :file,
      :styles =>{
        },
      :storage => :s3,
      :bucket => 'dreamfunded',
      :path => "csvfile/:id:filename",
      :url =>':s3_domain_url',
      :s3_protocol => :https,
      :s3_credentials => {
        :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
        :secret_access_key => "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"
      }

    validates_attachment_size :file, :less_than => 5.megabytes
    validates_attachment_content_type :file, :content_type =>["text/csv", "text/comma-separated-values", "application/vnd.ms-excel"]
    validates_attachment_content_type :file, content_type: ['text/csv', 'text/comma-separated-values', 'application/csv', 'application/excel', 'application/vnd.ms-excel', 'application/vnd.msexcel']
end
