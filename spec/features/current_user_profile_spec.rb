require 'rails_helper'

describe "Current user profile page", type: :feature, js: true do
  include_context "sign in helper"

  before do
    visit user_profile_path(current_user.profile)
  end

  it "should contain user info without any post" do
    profile = current_user.profile

    expect(page).to have_css(".avatar-photo")

    expect(page).to have_css(".profile-username")
    expect(page).to have_css("#edit-profile-button")
    expect(page).to have_content("#{profile.posts.count} posts")
    expect(page).to have_content("#{Friendship.where("owner_id = #{profile.id}").count} followers")
    expect(page).to have_content("#{Friendship.where("follower_id = #{profile.id}").count} following")

    expect(page).to have_content("Create new post")

    expect(page).not_to have_css(".dark-horizontal-separator")
    expect(page).not_to have_content("#{profile.name} posts".upcase)
    expect(page).not_to have_css(".user-posts-grid-column")
    expect(page).not_to have_css("img.user-profile-post-image")
  end

  it "should contain user posts" do
    profile = current_user.profile
    FactoryBot.create(:post, :user_profile_id => profile.id).save!
    visit user_profile_path(current_user.profile)

    expect(page).to have_css(".dark-horizontal-separator")
    expect(page).to have_content("#{profile.name} posts".upcase)
    expect(page).to have_css(".user-posts-grid-column")
    expect(page).to have_css("img.user-profile-post-image")

  end

  it "should edit user profile" do
    profile = current_user.profile

    click_on("Edit profile")
    expect(page).to have_content("Edit your profile")
    expect(page).to have_field('user_profile_name', with: "#{profile.name}")
    expect(page).to have_field('user_profile_age', with: "#{profile.age}")
    expect(page).to have_css("#profile_avatar_label")
  end

end
