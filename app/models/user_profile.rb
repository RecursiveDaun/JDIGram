class UserProfile < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id', dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id', dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one_attached  :avatar
end
