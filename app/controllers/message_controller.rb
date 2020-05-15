class MessageController < ApplicationController

  def create
    message = Message.new
    message.update_attributes(body: params[:message_text],
                              author_id: current_user.user_profile.id,
                              conversation_id: params[:conversation_id])
    if message.save
      username = current_user.user_profile.name || current_user.nickname
      render json: { username: username }
    end
  end

end
