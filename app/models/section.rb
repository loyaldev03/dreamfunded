class Section < ActiveRecord::Base
	belongs_to :company

	# validates :id, presence:true
	# validates :overview, presence:true
end
