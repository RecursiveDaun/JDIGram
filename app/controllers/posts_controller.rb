class PostsController < ApplicationController

  # ====================================== Filters and other ====================================== #
  before_action :find_post_by_params, only: [:show, :update]
  before_action :find_user_profile_by_params, only: [:new, :create]

  # ====================================== Actions ====================================== #
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
    @post.user_profile_id = @user_profile.id
  end

  def create
    p '====================================================================================='
    p params
    p '====================================================================================='
    @post = Post.new
    @post.description = post_params[:description]
    @post.user_profile_id = @user_profile
    create_photo
    if @post.save
      p 'all is ok'
      redirect_to profile_path(@user_profile)
    else
      p @post.errors
      render 'posts/new'
    end
  end

  def update
  end

  # ====================================== Private Methods ====================================== #
  private

  def find_user_profile_by_params
    if is_id_number?(params[:profile_id])
      @user_profile = UserProfile.find(params[:id])
    else
      @user_profile = User.where('link_hash = ?', params[:profile_id]).first.user_profile
    end
  end


  private

  def post_params
    params.require(:post)
  end

  private

  def allowed_params
    params.require(:post).permit(:description)
  end

  private

  def find_post_by_params
    @post = Post.find(params[:id])
  end

  private

  def photo_params
    params.require(:post).require(:post_image)
  end

  private

  def create_photo
    @photo = Photo.new
    @photo.data = photo_params.read
    @photo.filename = photo_params.original_filename
    @photo.image_type = photo_params.content_type
    @photo.post = @post
    @photo.save!
  end

end
