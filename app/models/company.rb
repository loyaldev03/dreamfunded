class Company < ActiveRecord::Base
	belongs_to :user

	has_many :section
	has_many :founders
	has_many :snapshots

	validates :user_id, presence:true
	validates :name, presence:true
	validates_uniqueness_of :name
	validates :description, presence:true
	validates :image_file_name, presence:true
	validates :invested_amount, presence:true
	validates :goal_amount, presence:true
	validates :status, presence:true

	def self.Status
		{
			:Coming_Soon => 1, 
			:Active => 2,
			:Funded => 3,
		}
	end

	def get_status 
		if self.status == 1
			"Coming Soon"
		elsif self.status == 2
			"Active"
		elsif self.status == 3
			"Funded"
		end
	end
end