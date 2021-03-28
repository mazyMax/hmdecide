class PostsController < ApplicationController
    
    @posts = Post.all
    
    def create

    post_true_params = {description: post_params[:description], image: post_params[:image], user_id: post_params[:user_id]}

    @post = Post.new(post_true_params)

    if @post.valid?
      @post.save
        puts @post.id



       images_list_params = {images: post_params[:choices_attributes], user_id: post_params[:user_id], post_id: @post.id}


       images_list_params[:images].each do |img|

           choice_params = {images: img[1]['images'], 
               user_id: post_params[:user_id], 
               post_id: @post.id}
           #puts choice_params
           
           Choice.create(choice_params)
       end
        
       redirect_to root_path
    else
      flash.now[:messages] = @post.errors.full_messages[0]
      render :new
    end
  end
    
#     def new
#         @post = Post.new
#         @post.choices.build
#     end
    
    
   


   def show
       id = params[:id]
       @post = Post.find(id)
   end
   
#    def destroy
#      @post = current_user.posts.find(params[:id])
#      @post.destroy
#     redirect_to user_path(current_user)
#    end
    
    private
    def post_params
#       params.require(:post).permit(:description, :image, :user_id, :images)
#         params.require(:post).permit(:description, :image, :user_id, :images=choices_attributes: Choice.attribute_names.map(&:to_sym).push(:_destroy))
#        params.require(:post).permit(:description, :image, :user_id, choices_attributes:[:images])
# params.require(:post).permit(:description, :image, :user_id, {images: []} )
        
        params.require(:post).permit(:description, :image, :user_id, choices_attributes:[:images])
        
    end
end
