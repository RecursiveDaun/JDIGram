class ProfileController < ApplicationController

  # ======================== Filters ========================
  before_action :find_user_profile_by_params, only: [:show, :edit, :update, :follow]

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
    friendship = Friendship.new
    friendship.owner_id = @profile.id
    friendship.follower_id = current_user.user_profile.id
    friendship.save
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
