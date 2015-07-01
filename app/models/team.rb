class Team < ActiveRecord::Base
	validates :full_name, presence:true
	validates :image_name, presence:true
	validates :description, presence:true
	validates :full_bio, presence:true
end
