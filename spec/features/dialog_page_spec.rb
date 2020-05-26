require 'rails_helper'

describe "Dialog page", type: :feature, js: true do

  let(:current_user) { User.where(nickname: 'first').first }
  let(:conversation) { Conversation.where('author_id = ? OR receiver_id = ?', current_user.profile.id, current_user.profile.id).first }

  it "should contain messages" do
    visit '/'
    # Sign in with existing user
    fill_in :user_login, with: current_user.nickname
    fill_in :user_password, with: '123123'
    click_button 'Sign in'

    visit conversation_path(conversation)

    expect(page).to have_css(".messages-column")
    expect(page).to have_css(".conversation-companion-name")
    expect(page).to have_css("#messages_#{conversation.id}")

    if conversation.messages.count > 0
      expect(page).to have_css(".button_avatar_link_to_profile")
      expect(page).to have_css(".avatar_link_to_profile")
      expect(page).to have_css(".message-author")
      expect(page).to have_css(".message-time")
      expect(page).to have_css(".message-body")
    else
      expect(page).to have_no_css(".button_avatar_link_to_profile")
      expect(page).to have_no_css(".avatar_link_to_profile")
      expect(page).to have_no_css(".message-author")
      expect(page).to have_no_css(".message-time")
      expect(page).to have_no_css(".message-body")
    end

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

end
