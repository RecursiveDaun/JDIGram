class Like < ApplicationRecord
  belongs_to :user_profile
  belongs_to :post
end
