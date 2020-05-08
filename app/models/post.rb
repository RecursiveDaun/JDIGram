class Post < ApplicationRecord
  belongs_to  :user_profile
  has_one_attached :photo
end
