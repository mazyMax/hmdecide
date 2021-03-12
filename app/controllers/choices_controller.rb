class ChoicesController < ApplicationController
    def index
        @choices = Choice.all
    end

    def show
        id = params[:id]
        @choice = Choice.find(id)
    end
    
    private
    def choice_params
      params.require(:choice).permit(:images, :topic_id)
    end
    
end
