require 'rails_helper'

describe "Current user profile page", type: :feature, js: true do

  let(:profile) { UserProfile.first }
  it "should contain" do
    visit '/'
    # Sign in with existing user
    fill_in :user_login, with: 'first'
    fill_in :user_password, with: '123123'
    click_button 'Sign in'

    # User profile page
    visit user_profile_path(profile)

    expect(page).to have_css(".avatar-photo")

    expect(page).to have_css(".profile-username")
    expect(page).to have_css("#edit-profile-button")
    expect(page).to have_content("#{profile.posts.count} posts")
    expect(page).to have_content("#{Friendship.where("owner_id = #{profile.id}").count} followers")
    expect(page).to have_content("#{Friendship.where("follower_id = #{profile.id}").count} following")

    expect(page).to have_content("Create new post")
    if profile.posts.present?
      expect(page).to have_css(".dark-horizontal-separator")
      expect(page).to have_content("#{profile.name} posts".upcase)
      expect(page).to have_css(".user-posts-grid-column")
      expect(page).to have_css("img.user-profile-post-image")
    else
      expect(page).to have_no_css(".dark-horizontal-separator")
      expect(page).to have_no_content("#{profile.name} posts".upcase)
      expect(page).to have_no_css(".user-posts-grid-column")
      expect(page).to have_no_css("img.user-profile-post-image")
    end

    # Test edit profile
    click_on("Edit profile")
    expect(page).to have_content("Edit your profile")
    expect(page).to have_field('user_profile_name', with: "#{profile.name}")
    expect(page).to have_field('user_profile_age', with: "#{profile.age}")
    expect(page).to have_css("#profile_avatar_label")
  end

end
