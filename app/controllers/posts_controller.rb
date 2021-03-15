class PostsController < ApplicationController
    def create
      #@post = Post.create!(post_params)
      #redirect_to root_path   
     @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      flash.now[:messages] = @post.errors.full_messages[0]
      render :new
    end
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
