class GeneralInfo < ActiveRecord::Base

  belongs_to :company

  has_one :financial_detail
  accepts_nested_attributes_for :financial_detail, reject_if: :all_blank, allow_destroy: true

  has_many :officers
  accepts_nested_attributes_for :officers, reject_if: :all_blank, allow_destroy: true

  has_many :principal_holders
  accepts_nested_attributes_for :principal_holders, reject_if: :all_blank, allow_destroy: true

  has_many :securities
  accepts_nested_attributes_for :securities, reject_if: :all_blank, allow_destroy: true

  has_many :terms
  accepts_nested_attributes_for :terms, reject_if: :all_blank, allow_destroy: true

  has_many :investment_perks
  accepts_nested_attributes_for :investment_perks, reject_if: :all_blank, allow_destroy: true

  has_many :risks
  accepts_nested_attributes_for :risks, reject_if: :all_blank, allow_destroy: true

  has_many :fundraise_tiers
  accepts_nested_attributes_for :fundraise_tiers, reject_if: :all_blank, allow_destroy: true

  has_attached_file :cap_table, :storage => :s3, :bucket => 'dreamfunded', :path => "documents/:filename",
    :url =>':s3_domain_url', :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
  validates_attachment_content_type :cap_table, :content_type =>['application/pdf']



  has_attached_file :last_year_financials, :storage => :s3, :bucket => 'dreamfunded',
    :path => "documents/:filename", :url =>':s3_domain_url', :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
  validates_attachment_content_type :last_year_financials, :content_type =>['application/pdf']

  has_attached_file :cpa_review, :storage => :s3, :bucket => 'dreamfunded',
    :path => "documents/:filename", :url =>':s3_domain_url', :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
  validates_attachment_content_type :cpa_review, :content_type =>['application/pdf']

  has_attached_file :last_2years_financials, :storage => :s3, :bucket => 'dreamfunded',
    :path => "documents/:filename", :url =>':s3_domain_url', :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
  validates_attachment_content_type :last_2years_financials, :content_type =>['application/pdf']

  has_attached_file :last_year_taxes, :storage => :s3, :bucket => 'dreamfunded',
    :path => "documents/:filename", :url =>':s3_domain_url', :s3_protocol => :https,
    :s3_credentials => {
      :access_key_id => "AKIAJWDE6UJS56MXQYPQ",
      :secret_access_key => "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"
    }
  validates_attachment_content_type :last_year_taxes, :content_type =>['application/pdf']

  def address
    self.company_location_address + ", "+ self.company_location_city + ", " + self.company_location_state + ", " +  self.company_location_zipcode
  end

  def dead_line
    Date.today + self.days
  end

  def team_names
    self.principal_holders.map(&:name).join(", ")
  end

  def team_titles
    self.principal_holders.map(&:title).join(", ")
  end


  def addit_financing
    self.additional_financing ? 'Will' : 'Will not'
  end

  def add_sources_capital
    self.additional_sources_capital ? 'Does' : 'Does not'
  end

  def add_sources_necessary
    self.additional_sources_necessary ? 'Are' : 'Are not'
  end

  def has_material_captl
    self.has_material_capital ? 'Have' : 'Have not'
  end


end
