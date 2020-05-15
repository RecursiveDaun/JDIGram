class ConversationController < ApplicationController

  before_action :find_conversation_by_params, only: [:show]

  def index
    @conversations = Conversation.where('author_id = ? OR receiver_id = ?',
                                        current_user.user_profile.id,
                                        current_user.user_profile.id)
  end

  def show
    respond_to do |format|
      format.js
      format.html { render 'conversation/show' }
    end
  end

  def create
    conversation = Conversation.where('author_id IN (?, ?) AND receiver_id IN (?, ?)',
                                      current_user.user_profile.id,
                                      params[:format],
                                      current_user.user_profile.id,
                                      params[:format]).first
    if conversation.blank?
      conversation = Conversation.new
      conversation.update_attributes(author_id: current_user.user_profile.id, receiver_id: fetch_receiver_id_from_params)
      conversation.save
    end

    redirect_to conversation_path(conversation.id)
  end


  private

  def find_conversation_by_params
    conv_id = params[:id] || params[:format]
    @conversation = Conversation.find(conv_id)
  end

  def fetch_receiver_id_from_params
    params[:id] || params[:format]
  end

end
