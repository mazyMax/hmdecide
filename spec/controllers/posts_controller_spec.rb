require 'rails_helper'

describe PostsController do
  #reference: https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
  PostsController.new
  it "create a new post in database" do
    Post.destroy_all
    expect { 
      post :create, post: FactoryBot.attributes_for(:post) 
    }.to change(Post, :count).by(1) 
  end
  
end