require 'rails_helper'

describe "Dialog page", type: :feature, js: true do
  include_context "sign in helper"

  it "should not contain messages" do
    conversation = create_conversation
    visit conversation_path(conversation)

    expect(page).to have_css(".messages-column")
    expect(page).to have_css(".conversation-companion-name")
    expect(page).to have_css("#messages_#{conversation.id}")

    expect(page).not_to have_css("#messages_#{conversation.id} .button_avatar_link_to_profile")
    expect(page).not_to have_css(".message-author")
    expect(page).not_to have_css(".message-time")
    expect(page).not_to have_css(".message-body")
  end

  it "should send and display new message" do
    conversation = create_conversation
    visit conversation_path(conversation)

    # Send new message
    fill_in "new-message-text-area", with: "new message"
    click_button "Send"

    # New message info
    expect(page).to have_css(".button_avatar_link_to_profile")
    expect(page).to have_css(".avatar_link_to_profile")
    expect(page).to have_css(".message-author")
    expect(page).to have_css(".message-time")
    expect(page).to have_css(".message-body")
  end

  def create_conversation
    alien_user_profile = FactoryBot.create(:user).profile
    FactoryBot.create(:conversation,
                      :author_id => current_user.profile.id,
                      :receiver_id => alien_user_profile.id).save!
    conversation = Conversation.where('author_id = ? OR receiver_id = ?',
                                      current_user.profile.id,
                                      current_user.profile.id).first
    return conversation
  end

end
