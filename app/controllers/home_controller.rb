class HomeController < ApplicationController
  def index

       @posts = Post.where(["description LIKE ?","%#{params[:search]}%"])

  end
    
  def about
  end
end
