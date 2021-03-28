class HomeController < ApplicationController
  def index
       #@posts = Post.order(created_at: :desc)
      @posts = Post.where(["description LIKE ?","%#{params[:search]}%"])
#       if params[:search]
#           @posts = Post.search(params[:search])
#       end
  end
    
  def about
  end
end
