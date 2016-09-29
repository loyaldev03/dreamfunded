require 'csv'
class Invite < ActiveRecord::Base
  belongs_to :user

  before_save :set_token


  def set_token
    self.token ||= SecureRandom.uuid.gsub(/\-/, '').first(5).upcase
  end

  def use_token
    self.update(status: 'User signed up, but hasn\'t invested yet')
  end

  def self.import(file, user_id)
    CSV.foreach(file.path, headers: true) do |row|

      product_hash = row.to_hash # exclude the price field
      Guest.create!(email: row['Email'], name: row['Name'], user_id: user_id)

    end # end CSV.foreach
  end # end self.import(file)

end
