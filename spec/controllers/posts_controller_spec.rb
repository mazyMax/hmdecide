require 'rails_helper'
def clean_db
    Choice.destroy_all
    Post.destroy_all
    User.destroy_all
end

describe PostsController do
    #reference: https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
    
    # PostsController.new
    # Post.destroy_all
    # Choice.destroy_all
    # User.destroy_all
    
    # test1 = FactoryBot.create(:user,
    #     email: "728977862@qq.com", 
    #     password: "4156GOGOGO", 
    #     created_at: "2021-03-13 11:04:06",
    #     updated_at: "2021-03-13 11:04:06"
    # )
    
    
   
    describe "POST create" do
      # https://www.rubydoc.info/docs/rails/4.1.7/ActionController/Parameters
      it "successfully complete creation" do
        clean_db
        test1 = FactoryBot.create(:user,
            email: "728977862@qq.com", 
            password: "4156GOGOGO", 
            created_at: "2021-03-13 11:04:06",
            updated_at: "2021-03-13 11:04:06"
        )

        hash_param = FactoryBot.attributes_for(:post)
        hash_param[:user_id] = User.all.take.id     
        images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
        images_list_param = {"12345"=>images_param}       
        hash_param["choices_attributes"] = images_list_param
        

        expect { 
          post :create, params: {post: hash_param}
        }.to change(Post, :count).by(1)
      end
  
        
      it "fails to complete without uploading choices" do 
        clean_db
        test1 = FactoryBot.create(:user,
            email: "728977862@qq.com", 
            password: "4156GOGOGO", 
            created_at: "2021-03-13 11:04:06",
            updated_at: "2021-03-13 11:04:06"
        )

          hash_param = FactoryBot.attributes_for(:post)
          hash_param[:user_id] = User.all.take.id     

          
          post :create, params: {post: hash_param}
          flash.now[:notice].should == "Please upload your choices!"
      end

      it "fails to complete with wrong choices file type" do

        clean_db
        test1 = FactoryBot.create(:user,
            email: "728977862@qq.com", 
            password: "4156GOGOGO", 
            created_at: "2021-03-13 11:04:06",
            updated_at: "2021-03-13 11:04:06"
        )

        hash_param = FactoryBot.attributes_for(:post)
        hash_param[:user_id] = User.all.take.id     
        images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'wrong_choice.txt'), 'text/plain')}
        images_list_param = {"12345"=>images_param}       
        hash_param["choices_attributes"] = images_list_param
        

        expect { 
          post :create, params: {post: hash_param}
        }.to change(Post, :count).by(0)

      end 
        
      it "fails to complete with wrong information" do
        clean_db
        test1 = FactoryBot.create(:user,
            email: "728977862@qq.com", 
            password: "4156GOGOGO", 
            created_at: "2021-03-13 11:04:06",
            updated_at: "2021-03-13 11:04:06"
        )
          
          hash_param = FactoryBot.attributes_for(:post)
          hash_param[:user_id] = User.all.take.id   
          post :create, params: {post: {post:hash_param}}
          
          flash.now[:messages].should == "User must exist"
      end  
        
        
    end
    

    
   describe "GET show" do
       it "show the posts that one user creates"do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

           hash_param = FactoryBot.attributes_for(:post)
           hash_param[:user_id] = User.all.take.id     
           images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
           images_list_param = {"12345"=>images_param}       
           hash_param["choices_attributes"] = images_list_param
           
           post :create, params: {post: hash_param}
           get :show, params: {id: Post.where("description = ?", "AAAAA").take.id}
           expect(response.status).to eq(200)

       end
   end
    
   describe "POST destroy" do
       it "destroys posts using post_id" do

            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )
           
           post_test = FactoryBot.create(:post,
            user_id: User.all.take.id
            )
            choice_test = FactoryBot.create(:choice,
                post_id: Post.all.take.id,
                user_id: User.all.take.id
            )
           hash_param = {}
           hash_param[:id] = Post.all.take.id
           expect { 
               delete :destroy, params: hash_param
           }.to change(Post, :count).by(-1)
 
           
       end
   end

   describe "POST change_to_public" do
        it "change the visibility of post to public" do

            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            post_test = FactoryBot.create(:post,
                user_id: User.all.take.id
                )
            choice_test = FactoryBot.create(:choice,
                post_id: Post.all.take.id,
                user_id: User.all.take.id
            )
            
            hash_param = {}
            hash_param[:id] = Post.all.take.id
            post :change_to_public, params: hash_param
            expect(Post.all.take.visibility == "public")

        end
   end

   describe "POST change_to_private" do
        it "change the visibility of post to private" do

            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            post_test = FactoryBot.create(:post,
                user_id: User.all.take.id
                )
            choice_test = FactoryBot.create(:choice,
                post_id: Post.all.take.id,
                user_id: User.all.take.id
            )
            
            hash_param = {}
            hash_param[:id] = Post.all.take.id
            post :change_to_private, params: hash_param
            expect(Post.all.take.visibility == "private")

        end
    end

    describe "POST change_to_followers_only" do
        it "change the visibility of post to followers_only" do

            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            post_test = FactoryBot.create(:post,
                user_id: User.all.take.id
                )
            choice_test = FactoryBot.create(:choice,
                post_id: Post.all.take.id,
                user_id: User.all.take.id
            )
            
            hash_param = {}
            hash_param[:id] = Post.all.take.id
            post :change_to_followers_only, params: hash_param
            expect(Post.all.take.visibility == "follow")

        end
    end

    describe "POST close_posts" do
        it "change the close status of the vote to be 1" do

            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            post_test = FactoryBot.create(:post,
                user_id: User.all.take.id
                )
            choice_test = FactoryBot.create(:choice,
                post_id: Post.all.take.id,
                user_id: User.all.take.id
            )
            
            hash_param = {}
            hash_param[:id] = Post.all.take.id
            post :close_posts, params: hash_param
            expect(Post.all.take.close == "1")

        end
    end

    
    

end
