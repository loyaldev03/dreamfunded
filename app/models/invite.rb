class Invite < ActiveRecord::Base
  belongs_to :user

  before_save :set_token

  def set_token
    self.token ||= SecureRandom.uuid.gsub(/\-/, '').first(5).upcase
  end

  def use_token
    self.update(status: 'User signed up, but hasn\'t invested yet')
  end

  # def status
  #   if signedup
  #     'User signed up, but hasn\'t invested yet'
  #   else
  #     "Hasn't signed up yet"
  #   end
  # end

end
