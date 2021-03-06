require 'rails_helper'

describe "Alien user profile page", type: :feature, js: true do
  include_context "sign in helper"

  it "should contain" do
    # User profile page
    current_user_profile = current_user.profile

    alien_user_profile = FactoryBot.create(:user).profile
    visit user_profile_path(alien_user_profile)

    expect(page).to have_css(".avatar-photo")
    expect(page).to have_css(".profile-username")

    if Friendship.where('owner_id = ? AND follower_id = ?', alien_user_profile.id, current_user_profile.id).first.present?
      expect(page).to have_css("#open-conversation-button")
    end
    expect(page).to have_css("#follow-unfollow-button")
    expect(page).to have_content("#{alien_user_profile.posts.count} posts")
    expect(page).to have_content("#{Friendship.where("owner_id = #{alien_user_profile.id}").count} followers")
    expect(page).to have_content("#{Friendship.where("follower_id = #{alien_user_profile.id}").count} following")

    if alien_user_profile.posts.present?
      expect(page).to have_css(".dark-horizontal-separator")
      expect(page).to have_content("#{alien_user_profile.name} posts".upcase)
      expect(page).to have_css(".user-posts-grid-column")

      expect(page).to have_css("img.user-profile-post-image")
    end

  end

end
