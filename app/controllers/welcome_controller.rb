class WelcomeController < ApplicationController

  def index
    p '=====ad=as=asf=as=fas=f=asf=as=fas=f=as=fas=f=asf=as=f'
    @posts = Post.all
    p @posts
  end

end
