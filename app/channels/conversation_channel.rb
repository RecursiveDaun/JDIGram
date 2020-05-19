class ConversationChannel < ApplicationCable::Channel

  def subscribed
    stream_from "conversation"
  end

end