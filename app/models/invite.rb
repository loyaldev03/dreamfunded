require 'csv'
class Invite < ActiveRecord::Base
  belongs_to :user
  before_save :set_token

  validates :email, presence: true


  def set_token
    self.token ||= SecureRandom.uuid.gsub(/\-/, '').first(5).upcase
  end

  def use_token
    self.update(status: 'User signed up, but hasn\'t invested yet')
  end

  def self.import(file, user_id)
    invites = []
    CSV.foreach(file.path, headers: true) do |row|

      product_hash = row.to_hash # exclude the price field
      invites << Invite.create!(email: row['Email'], name: row['First Name'], user_id: user_id)

    end # end CSV.foreach
    invites
  end # end self.import(file)

end
