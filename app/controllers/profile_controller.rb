class ProfileController < ApplicationController

  def show
    if is_id_number?(params[:id])
      @profile = User.find(params[:id])
    else
      @profile = User.where('link_hash = ?', params[:id]).first.user_profile
    end
  end

  def edit
    @profile = UserProfile.find(params[:id])
  end

  def update
    @profile = UserProfile.find(params[:id])
    avatarData = params[:user_profile][:avatar]
    @profile.avatar.attach(avatarData)
    if @profile.save
      redirect_to action: 'show'
    end
  end

  def allowed_params
    params.require(:user_profile).permit(:age, :name, :avatar)
  end

  def photo_params
    params.require(:user_profile).require(:data)
  end

  # private
  # def create_photo
  #   @photo = Photo.new
  #   @photo.data = photo_params.read
  #   @photo.filename = photo_params.original_filename
  #   @photo.image_type = photo_params.content_type
  #   @photo.user_profile = @profile
  #   @photo.save!
  # end

end
