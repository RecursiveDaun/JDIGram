class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "conversation",
                                 message: render_message(message)
  end

  private

  def render_message(message)
    MessageController.render partial: 'message', locals: { message: message }
  end

end