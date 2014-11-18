class User < ActiveRecord::Base

  #attr_accessor :password_confirmation
  has_many :votes
  has_many :songs, :through =>:votes
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

end