require 'rails_helper'

describe "Sign up user", type: :feature, js: true do

  it "should show sign in page" do
    visit '/'
    expect(page).to have_content("Sign in")
    expect(page).to have_css("#user_login")
    expect(page).to have_css("#user_password")
    expect(page).to have_button("Sign in")
  end

  it 'should create a new user' do
    visit new_user_registration_path

    expect(page).to have_content("Sign up")
    expect(page).to have_css("#user_email")
    expect(page).to have_css("#user_nickname")
    expect(page).to have_css("#user_password")
    expect(page).to have_css("#user_password_confirmation")

    password = FFaker::Internet.password

    fill_in :user_email, with: FFaker::Internet.unique.email
    fill_in :user_nickname, with: FFaker::Internet.unique.user_name
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    users_count = User.count
    click_button 'Sign up' # Register a new user, after that the users count should be incremented
    expect(User.count).to eq(users_count + 1)
    expect(UserProfile.count).to eq(users_count + 1)
  end

  it 'shouldn\'t create a new user because password confirm is wrong' do
    visit new_user_registration_path

    expect(page).to have_content("Sign up")
    expect(page).to have_css("#user_email")
    expect(page).to have_css("#user_nickname")
    expect(page).to have_css("#user_password")
    expect(page).to have_css("#user_password_confirmation")

    fill_in :user_email, with: FFaker::Internet.unique.email
    fill_in :user_nickname, with: FFaker::Internet.unique.user_name
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: '1235312' # This password doesn't confirm with that were be entered before

    users_count = User.count
    click_button 'Sign up' # Register a new user
    expect(User.count).to eq(users_count)
    expect(UserProfile.count).to eq(users_count)

  end

end
