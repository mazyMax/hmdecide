class UsersController < ApplicationController
    def show
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
      current_user.update(user_params)
      redirect_to current_user
    end


    def follow
      user_list = params[:id].split('/')
      # puts params[:id]
      follow_user = User.find(user_list[0])
      creater_of_the_post = User.find(user_list[1])
      User.operate_follow(follow_user, creater_of_the_post)
    end

    def unfollow
      user_list = params[:id].split('/')
      # puts params[:id]
      follow_user = User.find(user_list[0])
      creater_of_the_post = User.find(user_list[1])
      User.operate_unfollow(follow_user, creater_of_the_post)
    end

    private
    
    def user_params
      params.require(:user).permit(:username, :name, :website, :bio, :email, :phone, :gender)
    end
end
