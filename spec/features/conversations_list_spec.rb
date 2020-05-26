require 'rails_helper'

describe "Conversations list page", type: :feature, js: true do

  let(:current_user) { User.where(nickname: 'first').first }
  let(:current_user_profile) { current_user.profile }

  it "should contain dialogs list if they exist or shouldn't contain if they doesn't exist" do
    visit '/'
    # Sign in with existing user
    fill_in :user_login, with: current_user.nickname
    fill_in :user_password, with: '123123'
    click_button 'Sign in'

    # Conversations list
    visit conversation_index_path

    expect(page).to have_css(".conversations-list-column")
    # If conversations are exists, then our page should contain their preview data
    if Conversation.where('author_id = ? OR receiver_id = ?', current_user_profile.id, current_user_profile.id).count > 0
      expect(page).to have_css("img.avatar_link_to_profile")
      expect(page).to have_css(".conversation-companion-name")
      expect(page).to have_css(".conversation-latest-message-row")
      expect(page).to have_css(".conversation-last-message")
    # Else we should display nothing
    else
      expect(page).to have_no_css("img.avatar_link_to_profile")
      expect(page).to have_no_css(".conversation-companion-name")
      expect(page).to have_no_css(".conversation-latest-message-row")
      expect(page).to have_no_css(".conversation-last-message")
    end

  end

end
