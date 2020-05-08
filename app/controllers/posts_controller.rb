class PostsController < ApplicationController

  before_action :find_post_by_params, only: [:show, :update]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @user_profile = UserProfile.find(params[:profile_id])
    @post = Post.new
    @post.user_profile_id = @user_profile.id
  end

  def create
  end

  def update
  end


  def allowed_params
    params.require(:post).permit(:description)
  end

  private

  def find_post_by_params
    @post = Post.find(params[:id])
  end

end
