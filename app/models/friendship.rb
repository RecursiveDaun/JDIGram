class Friendship < ApplicationRecord
  # belongs_to :user_profile
  belongs_to :owner, class_name: 'UserProfile'
  belongs_to :follower, class_name: 'UserProfile'
end
