class PostsController < ApplicationController

    @posts = Post.all
    
    def create

        post_true_params = {description: post_params[:description], 
            image: post_params[:image], user_id: post_params[:user_id], 
            visibility: post_params[:visibility], who_can_see: post_params[:who_can_see], location: post_params[:location]}
        puts post_params
        puts "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ"
        puts post_true_params
        if post_true_params[:visibility] == "follow"
            # choose several followers
            puts"00000000000000000000000000000000000000000000000000000000000000000000000"
            post_true_params[:who_can_see] = Post.who_can_see_preprocess(post_true_params[:user_id], post_true_params[:who_can_see])
        end
        @post = Post.new(post_true_params)      
        puts"11111111"

        if @post.valid?   
            #puts"222222222222222"
            
            if post_params[:choices_attributes] != nil
                @post.save
                images_list_params = {images: post_params[:choices_attributes], user_id: post_params[:user_id], post_id: @post.id}
                images_list_params[:images].each do |img|
                    choice_params = {images: img[1]['images'], 
                        user_id: post_params[:user_id], 
                        post_id: @post.id}
                    Choice.create(choice_params)

                end
                
                redirect_to root_path            
            
            else
                
                flash[:notice] = "Please upload your choices!"
                render :new
            end
            
            
        else
            puts"333333333333333333"
            flash.now[:messages] = @post.errors.full_messages[0]
            render :new
        end
        
    
            
    end

    def change_to_public
        puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        puts params
        puts Post.find(params[:id]).visibility
        Post.find(params[:id]).update({"visibility": "public", "who_can_see": ""})
        flash[:notice] = "Changed to public!"
        redirect_to post_path(params[:id])
    end
    
    def change_to_private
        puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        puts params
        Post.find(params[:id]).update({"visibility": "private", "who_can_see": ""})
        flash[:notice] = "Changed to private!"
        redirect_to post_path(params[:id])
    end

    def change_who_can_see
        puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        puts params
        if params[:who_can_see] == ""
            Post.find(params[:id]).update({"visibility": "private", "who_can_see": ""})
            flash[:notice] = "Changed to private!"
            redirect_to post_path(params[:id])
        else
            Post.find(params[:id]).update({"who_can_see": params[:who_can_see]})
            flash[:notice] = "Only " + params[:who_can_see].to_s + " can see this post!"
            redirect_to post_path(params[:id])
        end
    end


    def close
        Post.find(params[:id]).update({"close": 1})
        flash[:notice] = "Vote closed!"
        redirect_to post_path(params[:id])
    end


   def show
       id = params[:id]
       @post = Post.find(id)
   end
   
   def destroy
    Choice.where("post_id = ?", params[:id]).destroy_all
    Post.where("id = ?", params[:id]).destroy_all
    redirect_to root_path
   end
    
    private
    def post_params
#       params.require(:post).permit(:description, :image, :user_id, :images)
#         params.require(:post).permit(:description, :image, :user_id, :images=choices_attributes: Choice.attribute_names.map(&:to_sym).push(:_destroy))
#        params.require(:post).permit(:description, :image, :user_id, choices_attributes:[:images])
# params.require(:post).permit(:description, :image, :user_id, {images: []} )
        
        params.require(:post).permit(:description, :image, :user_id, :visibility, :who_can_see, :location, choices_attributes:[:images])
        
    end
end
