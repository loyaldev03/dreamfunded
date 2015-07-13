class Team < ActiveRecord::Base
	validates :name, presence:true
	validates :file_name, presence:true
	validates :summary, presence:true
	validates :fullbio, presence:true
end
