require 'rails_helper'

describe "Alien user profile page", type: :feature, js: true do

  let(:current_user) { User.where(nickname: 'first').first }
  let(:current_user_profile) { current_user.profile }
  let(:profile) { UserProfile.last }

  it "should contain" do
    visit '/'
    # Sign in with existing user
    fill_in :user_login, with: current_user.nickname
    fill_in :user_password, with: '123123'
    click_button 'Sign in'

    # User profile page
    visit user_profile_path(profile)

    expect(page).to have_css(".avatar-photo")

    expect(page).to have_css(".profile-username")

    if Friendship.where('owner_id = ? AND follower_id = ?', profile.id, current_user_profile.id).first.present?
      expect(page).to have_css("#open-conversation-button")
    end
    expect(page).to have_css("#follow-unfollow-button")
    expect(page).to have_content("#{profile.posts.count} posts")
    expect(page).to have_content("#{Friendship.where("owner_id = #{profile.id}").count} followers")
    expect(page).to have_content("#{Friendship.where("follower_id = #{profile.id}").count} following")

    if profile.posts.present?
      expect(page).to have_css(".dark-horizontal-separator")
      expect(page).to have_content("#{profile.name} posts".upcase)
      expect(page).to have_css(".user-posts-grid-column")

      expect(page).to have_css("img.user-profile-post-image")
    end

  end

end
