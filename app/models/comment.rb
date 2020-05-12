class Comment < ApplicationRecord
  belongs_to  :post
  belongs_to  :user_profile
end
