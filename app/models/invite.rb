class Invite < ActiveRecord::Base
  belongs_to :user

  before_save :default_values
    def default_values
      self.token ||= SecureRandom.uuid.gsub(/\-/, '')
    end
end
