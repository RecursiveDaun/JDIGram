class ConversationController < ApplicationController

  def index
    @conversations = Conversation.where('author_id = ? OR receiver_id = ?',
                                        current_user.user_profile.id,
                                        current_user.user_profile.id)
  end

  def show
    p 'into conversation show'
    # @conversation = Conversation.find(params[:id])
    render plain: 'Hello'
  end

  def create
    conversation = Conversation.new
    conversation.update_attributes(author_id: current_user.user_profile.id, receiver_id: params[:receiver_id])
    conversation.save!
  end

end
