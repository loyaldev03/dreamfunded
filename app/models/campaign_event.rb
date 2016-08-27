class CampaignEvent < ActiveRecord::Base
  belongs_to :campaign


  validates_presence_of :campaign_id
  validates_inclusion_of :state, in: Campaign::STATES


end
