class Like < ApplicationRecord
  belongs_to :author, class_name: 'UserProfile', foreign_key: 'user_profile_id'
  belongs_to :post
end
