class ProfileController < ApplicationController

  def show
    @profile = UserProfile.find(params[:id])
  end

  def edit
    @profile = UserProfile.find(params[:id])
  end

  def update
    @profile = UserProfile.create(allowed_params)
    @profile.user = current_user
    create_photo
    if @profile.save
      redirect_to action: 'show'
    end
  end

  def allowed_params
    params.require(:user_profile).permit(:age, :name)
  end

  def photo_params
    params.require(:user_profile).require(:data)
  end

  private
  def create_photo
    @photo = Photo.new
    @photo.data = photo_params.read
    @photo.filename = photo_params.original_filename
    @photo.type = photo_params.content_type
    @photo.user_profile = @profile
  end
  
end
