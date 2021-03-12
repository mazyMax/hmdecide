class ChoicesController < ApplicationController
    def new
        @choice = Choice.new
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
    
    
    
    def index
        @choices = Choice.all
    end

    def show
        id = params[:id]
        @choice = Choice.find(id)
    end
    
    def upvote
        @choice.upvote_from current_user
        redirect_to post_path(2)
    end
    
    def downvote
        @choice.downvote_from current_user
        redirect_to post_path(2)
    end
    
    private
    def choice_params
      params.require(:choice).permit(:description, :images, :topic_id)
    end
    
end
