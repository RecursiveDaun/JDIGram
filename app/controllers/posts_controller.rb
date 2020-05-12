class PostsController < ApplicationController

  # ====================================== Filters and other ====================================== #
  before_action :find_post_by_params, only: [:update, :on_like_clicked]
  before_action :find_user_profile_by_params, only: [:new, :create]

  # ====================================== Actions ====================================== #

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

  # =================== Custom Actions ===================
  def on_like_clicked
    @like = Like.where(user_profile_id: current_user.user_profile.id, post_id: @post.id).first
    if @like.blank?
      @like = Like.new
      @like.post = @post
      @like.user_profile = current_user.user_profile
      @like.save
    else
      Like.destroy(@like.id)
    end
    redirect_to welcome_index_path
  end

  def add_comment
    @comment = Comment.new
    @comment.update_attributes(text: params[:post][:comments], post_id: params[:id], user_profile_id: params[:profile_id])
    @comment.save
  end

  # ====================================== Private Methods ====================================== #
  private
  # =================== Helpers ===================
  def find_user_profile_by_params
    @user_profile = current_user.user_profile
    # if is_id_number?(params[:profile_id])
    #   @user_profile = UserProfile.find(params[:profile_id])
    # else
    #   @user_profile = User.where('link_hash = ?', params[:profile_id]).first.user_profile
    # end
  end

  def find_post_by_params
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post)
  end

end
