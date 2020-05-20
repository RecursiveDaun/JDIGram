class UserProfile < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :friendships, foreign_key: 'owner_id', dependent: :destroy
  has_many :friendships, foreign_key: 'follower_id', dependent: :destroy
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id', dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id', dependent: :destroy
  has_many :messages, foreign_key: 'author_id', dependent: :destroy

  has_one_attached  :avatar
end
