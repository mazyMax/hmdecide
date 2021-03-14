class ChoicesController < ApplicationController
    before_action :authenticate_user!
     def index
        @choices = Choice.all
    end
    
    
    def show
        id = params[:id]
        @choice = Choice.find(id)
    end
    
    def new
    end
    
    def create
      #Choice.create(choice_params)
      #redirect_to root_path
      @choice = Choice.create(choice_params)
      if @choice.save
        redirect_to root_path
      else
      render 'new'
      flash[:notice] = "Didn't work"
      end
        
    end
    
   
    def update
        @choice = Choice.find params[:id]
        @choice.update_attributes!(choice_params)
        redirect_back(fallback_location: root_path)  
    end
    
    
    def upvote
        @choice = Choice.find params[:id]
        @choice.upvote_from current_user
        redirect_back(fallback_location: root_path)
    end
    
    def downvote
        @choice = Choice.find params[:id]
        @choice.downvote_from current_user
        redirect_to root_path
    end
    
    private
    def choice_params
      params.require(:choice).permit(:description, :images, :topic_id)
    end
    
end
