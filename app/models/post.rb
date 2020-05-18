class Post < ApplicationRecord
  belongs_to  :user_profile
  has_one_attached :photo, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_accessor :comment_text
end
