class PostsController < ApplicationController

  # ====================================== Filters and other ====================================== #
  before_action :find_post_by_params, only: [:show, :update]
  before_action :find_user_profile_by_params, only: [:new, :create]

  # ====================================== Actions ====================================== #

  # =================== Display ===================
  def index
    @posts = Post.all
  end

  def show
  end

  # =================== Create/Update ===================
  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.description = post_params[:description]
    @post.user_profile = @user_profile

    post_image_data = params[:post][:post_image]
    if !post_image_data.nil?
      @post.photo.attach(post_image_data)
    end

    if @post.save
      redirect_to profile_path(@user_profile)
    else
      render 'posts/new'
    end
  end

  def update
  end

  # ====================================== Private Methods ====================================== #
  private
  # =================== Helpers ===================
  def find_user_profile_by_params
    if is_id_number?(params[:profile_id])
      @user_profile = UserProfile.find(params[:profile_id])
    else
      @user_profile = User.where('link_hash = ?', params[:profile_id]).first.user_profile
    end
  end

  def find_post_by_params
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post)
  end

end
