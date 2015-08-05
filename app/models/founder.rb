class Founder < ActiveRecord::Base
	belongs_to :company

	validates :name, presence:true
	validates :position, presence:true
	validates :image_address, presence:true
	validates :content, presence:true
	validates :company_id, presence:true
	
end
