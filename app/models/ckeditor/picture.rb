class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :storage => :s3,
                    :bucket => 'dreamfunded',
                    :path => "documents/:filename",
                    :url =>':s3_domain_url',
                    :s3_protocol => :https,
                    :s3_credentials => {
                      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
                      :secret_access_key => "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"
                    },
                    :styles => { :content => '800>' }

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_content
    url(:content)
  end
end
