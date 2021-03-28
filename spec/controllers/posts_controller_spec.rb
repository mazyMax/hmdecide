require 'rails_helper'

describe PostsController do
    #reference: https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
    
    PostsController.new
    Post.destroy_all
    Choice.destroy_all
    User.destroy_all
    
    test1 = FactoryBot.create(:user,
        email: "728977862@qq.com", 
        password: "4156GOGOGO", 
        created_at: "2021-03-13 11:04:06",
        updated_at: "2021-03-13 11:04:06"
    )
    
    
   
    describe "POST create" do
      # https://www.rubydoc.info/docs/rails/4.1.7/ActionController/Parameters
      it "successfully complete creation" do 
        hash_param = FactoryBot.attributes_for(:post)
        hash_param[:user_id] = User.all.take.id     
        images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpg')}
        images_list_param = {"12345"=>images_param}       
        hash_param["choices_attributes"] = images_list_param
        

        expect { 
          post :create, params: {post: hash_param}
        }.to change(Post, :count).by(1)
      end
        
      it "fails to complete creation with wrong messages" do 
          hash_param = FactoryBot.attributes_for(:post)
          hash_param[:user_id] = User.all.take.id   
          post :create, params: {post: {post:hash_param}}
          flash.now[:messages].should == "User must exist"
      end
        
    end
    

    
   describe "GET show" do
       it "show the posts that one user creates"do
           hash_param = FactoryBot.attributes_for(:post)
           hash_param[:user_id] = User.all.take.id     
           images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpg')}
           images_list_param = {"12345"=>images_param}       
           hash_param["choices_attributes"] = images_list_param
           
           post :create, params: {post: hash_param}
           get :show, params: {id: Post.where("description = ?", "AAAAA").take.id}
           expect(response.status).to eq(200)

       end
   end
    
    
#    describe "POST destroy" do
#        it "destroys posts using ID"do
#            
#            #reference: https://stackoverflow.com/questions/24522294/rspec-how-to-stub-inherited-method-current-user-w-o-devise
#            allow(controller).to receive(:current_user).and_return(User.all.take)
#            #puts User.all.take.id
#            hash_param = FactoryBot.attributes_for(:post)
#            hash_param[:user_id] = User.all.take.id
#            post :create, params: {post: hash_param}
#            
#            #puts Post.all.take.user_id
#            
#            expect { 
#              post :destroy, params: {id: Post.all.take.id}
#            }.to change(Post, :count).by(-1) 
#            #and redirect_to root_path
#        end
#    end

end
