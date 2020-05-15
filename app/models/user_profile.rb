class UserProfile < ApplicationRecord
  belongs_to :user

  has_many :posts
  has_many :friendships
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :messages

  has_one_attached  :avatar
end
