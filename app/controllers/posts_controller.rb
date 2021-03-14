class PostsController < ApplicationController
    def create
      Post.create!(post_params)
      redirect_to root_path
    end
    
    def index
        @posts = Post.all
    end

    def show
        id = params[:id]
        @post = Post.find(id)
    end
    
    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
      redirect_to user_path(current_user)
    end
    
    private
    def post_params
      params.require(:post).permit(:description, :image, :user_id)
    end
end
