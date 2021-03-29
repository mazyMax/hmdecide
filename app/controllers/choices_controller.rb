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
        redirect_back(fallback_location: root_path)
    end
    
    
    private
    def choice_params
      params.require(:choice).permit(:description, :images, :post_id, :user_id)
    end
    
end
