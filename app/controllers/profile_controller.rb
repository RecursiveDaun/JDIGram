class ProfileController < ApplicationController

  before_action :find_user_profile_by_params, only: [:show, :edit, :update]

  def show
    @posts = Post.all.where(user_profile_id: @profile)
  end

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

  def allowed_params
    params.require(:user_profile).permit(:age, :name, :avatar)
  end

  private

  def find_user_profile_by_params
    if is_id_number?(params[:id])
      @profile = UserProfile.find(params[:id])
    else
      @profile = User.where('link_hash = ?', params[:id]).first.user_profile
    end
  end

end
