class WelcomeController < ApplicationController

  def index
    @posts = Post.all
    p @posts
  end

end
