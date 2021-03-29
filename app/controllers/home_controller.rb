class HomeController < ApplicationController
  def index

       @posts = Post.where(["description LIKE ?","%#{params[:search]}%"]).order(created_at: :desc)

  end
    
  def about
  end
end
