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

    render json: { likes_count: "#{@post.likes.count}" }
  end

  def add_comment
    comment_text = params[:comment_text]
    if params[:comment_text].blank?
      return
    end
    @comment = Comment.new
    @comment.update_attributes(text: comment_text,
                               post_id: params[:id],
                               user_profile_id: current_user.user_profile.id)
    @comment.save
    current_user_profile = current_user.user_profile
    render json: { username: "#{current_user_profile.name || current_user.nickname}",
                   user_profile_id: current_user_profile.id,
                   comment_text: comment_text }
  end

  # ====================================== Private Methods ====================================== #
  private
  # =================== Helpers ===================
  def find_user_profile_by_params
    @user_profile = current_user.user_profile
  end

  def find_post_by_params
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post)
  end

end
