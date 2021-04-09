class ChoicesController < ApplicationController
    #authentication constraint unfinished
    #before_action :authenticate_user!
    #def index
        
    #end
    
    
    def show
        @choices = Choice.all
        id = params[:id]
        @choice = Choice.find(id)
    end
    
    def create
        @post = Choice.create(choice_params)
    end
    
    

    def upvote
        @choice = Choice.find params[:id]
        @choice.upvote_from current_user
        @choice.update({"vote_count":  @choice.vote_count + 1  })
        Post.find(@choice.post_id).update({"vote_count": Post.find(@choice.post_id).vote_count + 1})
        current_user.update({"vote_count": current_user.vote_count + 1 })
        redirect_back(fallback_location: root_path)
    end
    
    
    private
    def choice_params
      params.require(:choice).permit(:description, :images, :post_id, :user_id)
    end
    
end
