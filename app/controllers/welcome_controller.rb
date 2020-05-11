class WelcomeController < ApplicationController

  def index
    @posts = Post.all
    p @posts
  end

  def post_was_liked
    p 'post_was_liked'
  end

end
