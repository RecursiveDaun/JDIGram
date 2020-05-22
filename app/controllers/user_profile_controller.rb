class UserProfileController < ApplicationController

  # ======================== Filters ========================
  before_action :find_user_profile_by_params, only: [:show, :edit, :update, :follow_unfollow, :friends]

  # ======================== Display ========================

  def new

  end

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
  # Follow/Unfollow to/from params[:profile_id] user
  def follow_unfollow
    friendship = Friendship.where('owner_id = ? AND follower_id = ?', @profile.id, current_user.profile.id).first
    if friendship.present?
      friendship.destroy
    else
      friendship = Friendship.new
      friendship.update_attributes(owner_id: @profile.id, follower_id: current_user.profile.id)
      friendship.save
    end

    respond_to do |format|
      format.js
    end
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
    profile_id = params[:id] || params[:profile_id] || params[:user_profile_id]
    if is_id_number?(profile_id)
      @profile = UserProfile.find(profile_id)
    else
      @profile = User.where('link_hash = ?', profile_id).first.profile
    end
  end

end
