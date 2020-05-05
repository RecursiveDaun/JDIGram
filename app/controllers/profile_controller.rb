class ProfileController < ApplicationController

  def show
    p 'Into show'
    @profile = UserProfile.find(params[:id])
    @photo = @profile.photos.last
    send_data(@photo.data, :type => @photo.image_type, :filename => "#{@photo.filename}.jpg", :disposition => 'inline')
  end

  def edit
    @profile = UserProfile.find(params[:id])
  end

  def update
    @profile = UserProfile.find(params[:id])
    create_photo
    @profile.photos.push(@photo)
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
    @photo.image_type = photo_params.content_type
    @photo.user_profile = @profile
    @photo.save!
  end

end
