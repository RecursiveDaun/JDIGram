class ProfileController < ApplicationController

  # ======================== Filters ========================
  before_action :find_user_profile_by_params, only: [:show, :edit, :update, :follow, :friends, :unfollow]

  # ======================== Display ========================
  def show
    @posts = Post.all.where(user_profile_id: @profile)
  end

  # ======================== Edit ========================
  def edit
  end

  def update
    profile_data = params[:user_profile]
    @profile.update_attributes(:name => profile_data[:name], :age => profile_data[:age])

    if profile_data[:avatar].nil? == false
      @profile.avatar.attach(profile_data[:avatar])
      if @profile.avatar.image? == false
        @profile.avatar.purge
        flash[:alert] = "Please, select image"
        redirect_to action: 'edit'
        return
      end
    end

    if @profile.save
      redirect_to action: 'show'
    end
  end

  # ======================== Custom Actions ========================
  # Follow to params[:id] user
  def follow
    # TODO: Follow/Unfollow
    friendship = Friendship.new
    friendship.update_attributes(owner_id: @profile.id, follower_id: current_user.user_profile.id)
    friendship.save
  end

  # Follow from params[:id] user
  def unfollow
    Friendship.where('owner_id = ? AND follower_id = ?', @profile.id, current_user.user_profile.id).first.destroy
  end

  # List of all friends
  def friends
    friendships = Friendship.where(follower_id: @profile.id)
    @friends = [ActiveRecord]
    friendships.each do |f|
      @friends.push(UserProfile.find(f.owner_id))
    end
    @friends.delete_at(0)
  end

  # ======================== Private Methods ========================
  private

  def find_user_profile_by_params
    profile_id = params[:id] || params[:profile_id]
    if is_id_number?(profile_id)
      @profile = UserProfile.find(profile_id)
    else
      @profile = User.where('link_hash = ?', profile_id).first.user_profile
    end
  end

end
