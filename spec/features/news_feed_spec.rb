require 'rails_helper'

describe "News feed", type: :feature, js: true do
  include_context "sign in helper"

  it "should not contain any post" do
    visit welcome_index_path
    expect(page).not_to have_css(".content_block")

    # Post header
    expect(page).not_to have_css(".content_block .button_avatar_link_to_profile")
    expect(page).not_to have_css(".content_block .avatar_link_to_profile")
    expect(page).not_to have_css("a.link_to_profile")

    # Post photo
    expect(page).not_to have_css("img.post_photo")

    # Like pannel
    expect(page).not_to have_css(".like-link")
    expect(page).not_to have_css("i.fa.fa-heart.filled-heart-icon, i.far.fa-heart.unfilled-heart-icon")
    expect(page).not_to have_css(".likes-count-span")

    # Comment
    expect(page).not_to have_css("#add-comment-button")
  end

  it "should contain post information" do
    profile = current_user.profile
    post = FactoryBot.create(:post, :user_profile_id => profile.id)

    visit welcome_index_path
    expect(page).to have_css(".content_block")

    # Post header
    expect(page).to have_css(".content_block .button_avatar_link_to_profile")
    expect(page).to have_css(".avatar_link_to_profile")
    expect(page).to have_css("a.link_to_profile")

    # Post photo
    expect(page).to have_css("img.post_photo")

    # Like pannel
    expect(page).to have_css(".like-link")
    expect(page).to have_css("i.fa.fa-heart.filled-heart-icon, i.far.fa-heart.unfilled-heart-icon")
    expect(page).to have_css(".likes-count-span")

    # Comment
    expect(page).to have_css("#comment-text-area-#{post.id}")
    expect(page).to have_css("#add-comment-button")
  end

end
