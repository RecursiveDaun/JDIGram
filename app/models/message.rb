class Message < ApplicationRecord
  belongs_to  :conversation
  belongs_to  :user_profile

  validates :body, presence: true

  after_create_commit do
    MessageBroadcastJob.perform_later(self)
  end
end
