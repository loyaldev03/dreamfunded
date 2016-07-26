class GeneralInfo < ActiveRecord::Base

  has_many :officers
  accepts_nested_attributes_for :officers, reject_if: :all_blank, allow_destroy: true

  has_many :principal_holders
  accepts_nested_attributes_for :principal_holders, reject_if: :all_blank, allow_destroy: true

  has_many :securities
  accepts_nested_attributes_for :securities, reject_if: :all_blank, allow_destroy: true

  has_attached_file :file,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :file, :content_type =>['application/pdf']

end
