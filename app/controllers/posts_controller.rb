class PostsController < ApplicationController
    def create
      Post.create(post_params)
      redirect_to root_path
    end
    
    def index
        @posts = Post.all
    end

    
    private
    def post_params
      params.require(:post).permit(:description, :image, :user_id)
    end
end
