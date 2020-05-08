class Post < ApplicationRecord
  belongs_to  :user_profile
  has_many    :photos
end
