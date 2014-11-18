class Song < ActiveRecord::Base

  has_many :votes
  has_many :users, :through => :votes
  validates :title, presence: true, length: { maximum: 100 }
  validates :artist, presence: true, length: { maximum: 100 }

  # def upvotes
  #   votes = self.votes
  #   total = 0
  #   votes.each do |v|
  #     total += 1 if v.value > 0
  #   end
  #   total
  # end

  # def downvotes
  #   votes = self.votes
  #   total = 0
  #   votes.each do |v|
  #     total += 1 if v.value < 0
  #   end
  #   total
  # end  

  # def total_votes
  #   upvotes - downvotes
  # end

end
