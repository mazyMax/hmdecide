require 'rails_helper'

describe PostsController do
  #reference: https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
  PostsController.new
  it "successfully complete creation" do   
    User.destroy_all
    test1 = FactoryBot.create(:user,
        email: "728977862@qq.com", 
        password: "4156GOGOGO", 
        created_at: "2021-03-13 11:04:06",
        updated_at: "2021-03-13 11:04:06"
    )
    expect { 
      post :create, params: {post: FactoryBot.attributes_for(:post)}
    }.to change(Post, :count).by(1) and redirect_to root_path
  end
end
