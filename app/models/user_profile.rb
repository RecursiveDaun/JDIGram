class UserProfile < ApplicationRecord
  belongs_to  :user
  has_many    :posts
  has_many    :friendships
  has_one_attached  :avatar
end
