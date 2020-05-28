class SearchController < ApplicationController

  def search
    if params['search-keyword'].blank?
      redirect_to welcome_index_path
      return
    end

    @users_profiles = [ActiveRecord]
    elastic_users = User.search(params['search-keyword'])
    elastic_users.each do |user|
      @users_profiles.push(User.find(user.id).profile)
    end
    @users_profiles.delete_at(0)

    elastic_user_profiles = UserProfile.search(params['search-keyword'])
    elastic_user_profiles.each do |profile|
      @users_profiles.push(UserProfile.find(profile.id))
    end

    @users_profiles = @users_profiles.uniq { |profile| profile.id }
    render :search_results
  end

end
