require 'csv'
class Invite < ActiveRecord::Base
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

  validates :email, presence: true
  validates_attachment_size :file, :less_than => 5.megabytes
  validates_attachment_content_type :file, :content_type =>["text/csv"]


  def set_token
    self.token ||= SecureRandom.uuid.gsub(/\-/, '').first(5).upcase
  end

  def use_token
    self.update(status: 'User signed up, but hasn\'t invested yet')
  end

  def self.import(file, user)
    invites = []
    CSV.foreach(file.path, headers: true) do |row|

      product_hash = row.to_hash
      invites << Invite.create!(email: row['Email'], name: row['First Name'], user_id: user.id)
      #ContactMailer.delay.csv_invite(invite, user)

    end # end CSV.foreach
    invites.each do |invite|
       ContactMailer.delay.csv_invite(invite, user)
    end
  end # end self.import(file)

end
