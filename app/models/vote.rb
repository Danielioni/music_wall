class Vote < ActiveRecord::Base

  belongs_to :vote
  belongs_to :user

  scope :upvotes, -> {where(value: 1).count}
  scope :downvotes, -> {where(value: -1).count}
  
end