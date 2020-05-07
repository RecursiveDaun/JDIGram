class ProfileController < ApplicationController

  before_action :find_profile_by_params, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    p '===================== Profile data ====================='
    profile_data = params[:user_profile]
    p '===================== Update Attributes ====================='
    @profile.update_attributes(:name => profile_data[:name], :age => profile_data[:age])
    p '===================== Avatar Condition ====================='
    if !profile_data[:avatar].nil?
      p '===================== Avatar::true ====================='
      @profile.avatar.attach(profile_data[:avatar])
    end
    p '===================== Save Condition ====================='
    if @profile.save
      p '===================== Save::true ====================='
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

  private

  def find_profile_by_params
    p '===================== Save Condition ====================='
    p params[:id], " ", is_id_number?(params[:id])
    if is_id_number?(params[:id])
      p '===================== is_id_number? true ====================='
      @profile = User.find(params[:id]).user_profile
    else
      p '===================== is_id_number? false ====================='
      @profile = User.where('link_hash = ?', params[:id]).first.user_profile
    end
  end

end
