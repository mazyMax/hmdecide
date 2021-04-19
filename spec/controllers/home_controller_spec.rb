require 'rails_helper'
def clean_db
    Choice.destroy_all
    Post.destroy_all
    User.destroy_all
end

#reference https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
describe HomeController do


    describe "GET index" do

        it "successfully request the page" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )
            allow(controller).to receive(:current_user).and_return(User.all.take)

            get :index
            expect(response.status).to eq(200)
        end
        

        it "renders the show template" do
            get :index
            response.should render_template :index
        end


        it "can search corresponding visible contents in the homepage" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )          

            @controller = PostsController.new
            #allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "which movie"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "public"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}


            @controller = PostsController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "private_card"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "private"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}

            test2 = FactoryBot.create(:user,
                email: "1234567@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )


            @controller = HomeController.new
            allow(controller).to receive(:current_user).and_return(User.where("email = ?", "1234567@qq.com").take)
            get :index, params: {search: "private_card"}
            get :index, params: {search: "movie"}
            expect(response.status).to eq(200)
        end


        it "can returns unsorted posts using popularity sort(without login)" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )
            
            @controller = PostsController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "which movie"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "public"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}

            @controller = HomeController.new

            get :index, params: {popular: "popular"}
            expect(response.status).to eq(200)
        end


        it "can sort posts by popularity in homepage(after login)" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )
            
            @controller = PostsController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "which movie"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "public"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}

            @controller = HomeController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            get :index, params: {popular: "popular"}
            expect(response.status).to eq(200)
        end


        it "can sort posts by location in homepage" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )
            
            @controller = PostsController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "which movie"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "public"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}
            puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts Post.all.take.description
            puts Post.all.take.location

            @controller = HomeController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts Post.all.take.description
            puts Post.all.take.location
            # "location"=>"37.090240,-95.712891"
            get :index, params: {:location => "37.090240,-95.712891"}
            expect(response.status).to eq(200)
        end


        it "can returns filtered posts using following relationship filter(without login)" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )
            

            @controller = PostsController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "which movie"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "follow"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}
 

            @controller = HomeController.new

            get :index, params: {follow: "follow"}
            expect(response.status).to eq(200)
        end


        it " filters posts using following relationship filter(after login)" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )
            

            @controller = PostsController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "which movie"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "follow"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}

            @controller = HomeController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            get :index, params: {follow: "follow"}
            expect(response.status).to eq(200)
        end


        it "filter closed votes in the homepage" do

            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            # time expires
            @controller = PostsController.new
            allow(@controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "time expires"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "public"
            hash_param[:close] = 0
            hash_param[:existingtime] = "0"
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}
            puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts Post.all.take.description
            puts Post.all.take.location

            # manually close vote
            @controller = PostsController.new
            allow(@controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:post)
            hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id
            hash_param[:description] = "manually close"
            hash_param[:location] = "37.090240,-95.712891"
            hash_param[:visibility] = "public"
            hash_param[:close] = 0
            hash_param[:existingtime] = ""
            images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpeg')}
            images_list_param = {"12345"=>images_param}       
            hash_param["choices_attributes"] = images_list_param
            post :create, params: {post: hash_param}
            puts "///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
            Post.where("description = ?", "manually close").take.update({"close": 1})
            puts Post.where("description = ?", "manually close").take.close


            @controller = HomeController.new
            allow(controller).to receive(:current_user).and_return(User.all.take)
            puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            puts Post.all.take.description
            puts Post.all.take.location
            # "location"=>"37.090240,-95.712891"
            get :index
            expect(response.status).to eq(200)
        end


    end


end