class WelcomeController < ApplicationController

  def index
    @user_profile = current_user.user_profile
  end

end
