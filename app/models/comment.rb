class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  belongs_to :comment
  has_many :comments
end
