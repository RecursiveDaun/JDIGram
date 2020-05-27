require 'rails_helper'

RSpec.shared_context "sign in helper" do

  before do
    @current_user = FactoryBot.create(:user)
    visit '/'
    fill_in :user_login, with: current_user.nickname
    fill_in :user_password, with: '123123'
    click_button 'Sign in'
  end

  let(:current_user) { @current_user }

end