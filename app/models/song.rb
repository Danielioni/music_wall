class Song < ActiveRecord::Base

  has_many :votes
  has_many :users, :through => :votes
  validates :title, presence: true, length: { maximum: 100 }
  validates :artist, presence: true, length: { maximum: 100 }

end
