class FinancialDetail < ActiveRecord::Base
  belongs_to :company
  belongs_to :general_info

  has_attached_file :balance_sheet,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :balance_sheet, :content_type =>['application/pdf']

  has_attached_file :income_statements,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :income_statements, :content_type =>['application/pdf']

  has_attached_file :statement_of_cash_flow,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :statement_of_cash_flow, :content_type =>['application/pdf']

  has_attached_file :statement_changes_of_equity,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :statement_changes_of_equity, :content_type =>['application/pdf']

  has_attached_file :business_plan,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :business_plan, :content_type =>['application/pdf']

  has_attached_file :party_transaction,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :party_transaction, :content_type =>['application/pdf']

  has_attached_file :intended_use_of_proceeds,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :intended_use_of_proceeds, :content_type =>['application/pdf']

  has_attached_file :capital_structure,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :capital_structure, :content_type =>['application/pdf']

  has_attached_file :material_terms,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :material_terms, :content_type =>['application/pdf']

  has_attached_file :directors_background,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :directors_background, :content_type =>['application/pdf']

  has_attached_file :accountant_review,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :accountant_review, :content_type =>['application/pdf']

  has_attached_file :financial_conditions,
    :storage => :s3,
    :bucket => 'dreamfunded',
    :path => "documents/:filename",
    :url =>':s3_domain_url',
    :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
    validates_attachment_content_type :financial_conditions, :content_type =>['application/pdf']

end
