class Post < ApplicationRecord
  belongs_to  :author, class_name: 'UserProfile', foreign_key: 'user_profile_id'
  has_one_attached :photo, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_accessor :comment_text
end
