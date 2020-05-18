class Conversation < ApplicationRecord
  belongs_to :author, class_name: 'UserProfile'
  belongs_to :receiver, class_name: 'UserProfile'

  has_many :messages, dependent: :destroy

  validates :author, uniqueness: {scope: :receiver}
end
