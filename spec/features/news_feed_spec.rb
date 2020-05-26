require 'rails_helper'

describe "News feed", type: :feature, js: true do

  let(:post) { Post.last }
  it "user should sign in" do
    visit '/'
    # Sign in with existing user
    fill_in :user_login, with: 'first'
    fill_in :user_password, with: '123123'
    click_button 'Sign in'

    visit welcome_index_path
    expect(page).to have_css(".content_block")

    # Post header
    expect(page).to have_css(".button_avatar_link_to_profile")
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
