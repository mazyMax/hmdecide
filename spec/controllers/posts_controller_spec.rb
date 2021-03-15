require 'rails_helper'

describe PostsController do
    #reference: https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
    
    PostsController.new
    Post.destroy_all
    User.destroy_all
    
    test1 = FactoryBot.create(:user,
        email: "728977862@qq.com", 
        password: "4156GOGOGO", 
        created_at: "2021-03-13 11:04:06",
        updated_at: "2021-03-13 11:04:06"
    )
    
#     render_views
    
#     describe "GET index" do
#       it "has a posts related heading" do
#         get :index
#         expect(response.body).to match /<h1>.*posts/im
#       end
#     end
    
    describe "create" do
      it "successfully complete creation" do 
        hash_param = FactoryBot.attributes_for(:post)
        hash_param[:user_id] = User.all.take.id
        expect { 
          post :create, params: {post: hash_param}
        }.to change(Post, :count).by(1) and redirect_to root_path
      end
    end
    
    describe "GET show" do
      it "shows the posts that one user creates" do 
        hash_param = FactoryBot.attributes_for(:post)
        hash_param[:user_id] = User.all.take.id
        post :create, params: {post: hash_param}
        get :show, params: {id: Post.where("description = ?", "AAAAA").take.id}
      end
    end
    
    describe "GET index" do
      it "shows the posts that one user creates" do 
        hash_param = FactoryBot.attributes_for(:post)
        hash_param[:user_id] = User.all.take.id
        post :create, params: {post: hash_param}
        get :index
      end
    end

end
