require 'rails_helper'

describe "Create new post", type: :feature, js: true do
  include_context "sign in helper"

  it "should contain" do

    profile = FactoryBot.create(:user).profile
    # User profile page
    visit new_post_path(profile)

    expect(page).to have_content("Description")
    expect(page).to have_css("#post_description")
    expect(page).to have_css("#post_image_label")

    # Test showing the error message when all fields are empty
    click_button "Upload"
    expect(page).to have_content("Please, fill all fields")

    # Test showing the error message when description filled but all others fields are empty
    fill_in :post_description, with: "Description"
    click_button "Upload"
    expect(page).to have_content("Please, fill all fields")

    # Test showing the error message when we attach file but other fields are empty
    attach_file("post_image", "/Users/user/megasync/arts/another arts/2D/love attack.jpg", make_visible: true)
    page.execute_script "window.scrollBy(0,10000)"
    click_button("Upload")
    expect(page).to have_content("Please, fill all fields")

    # Test redirect to success page after filling all the fields and creating a new post
    fill_in :post_description, with: "Description"
    attach_file("post_image", "/Users/user/megasync/arts/another arts/2D/love attack.jpg", make_visible: true)
    click_button "Upload"

    # After creating a new post we should redirect to current user profile page, and this page should contain .profile-username css class
    expect(page).to have_css(".profile-username")
  end

end
