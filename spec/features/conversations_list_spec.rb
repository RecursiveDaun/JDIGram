require 'rails_helper'

describe "Conversations list page", type: :feature, js: true do
  include_context "sign in helper"

  it "should not contain any conversation data" do
    visit conversation_index_path
    expect(page).to have_css(".conversations-list-column")

    expect(page).not_to have_css(".conversations-list-column .avatar_link_to_profile")
    expect(page).not_to have_css(".conversation-companion-name")
    expect(page).not_to have_css(".conversation-latest-message-row")
    expect(page).not_to have_css(".conversation-last-message")
  end

  it "should contain dialogs list" do
    # Conversations list
    visit conversation_index_path
    expect(page).to have_css(".conversations-list-column")

    current_user_profile = current_user.profile
    alien_user_profile = FactoryBot.create(:user).profile

    # Creating a new conversations and checks this page for css elements
    FactoryBot.create(:conversation, :author_id => current_user_profile.id, :receiver_id => alien_user_profile.id).save!
    visit conversation_index_path
    expect(page).to have_css("img.avatar_link_to_profile")
    expect(page).to have_css(".conversation-companion-name")
    expect(page).to have_css(".conversation-latest-message-row")
    expect(page).to have_css(".conversation-last-message")
  end

end