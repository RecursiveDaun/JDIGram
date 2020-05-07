class ProfileController < ApplicationController

  before_action :find_profile_by_params, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    profile_data = params[:user_profile]
    @profile.update_attributes(:name => profile_data[:name], :age => profile_data[:age])
    if !profile_data[:avatar].nil?
      @profile.avatar.attach(profile_data[:avatar])
    end
    if @profile.save
      redirect_to action: 'show'
    end
  end

  def allowed_params
    params.require(:user_profile).permit(:age, :name, :avatar)
  end

  # def photo_params
  #   params.require(:user_profile).require(:data)
  # end

  # private
  # def create_photo
  #   @photo = Photo.new
  #   @photo.data = photo_params.read
  #   @photo.filename = photo_params.original_filename
  #   @photo.image_type = photo_params.content_type
  #   @photo.user_profile = @profile
  #   @photo.save!
  # end

  private

  def find_profile_by_params
    if is_id_number?(params[:id])
      @profile = User.find(params[:id]).user_profile
    else
      @profile = User.where('link_hash = ?', params[:id]).first.user_profile
    end
  end

end
