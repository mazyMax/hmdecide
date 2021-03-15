require 'rails_helper'

#reference https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
describe ChoicesController do
    PostsController.new
    ChoicesController.new
    Post.destroy_all
    User.destroy_all
    Choice.destroy_all

    test1 = FactoryBot.create(:user,
        email: "728977862@qq.com", 
        password: "4156GOGOGO", 
        created_at: "2021-03-13 11:04:06",
        updated_at: "2021-03-13 11:04:06"
    )

    describe "POST create" do
        it "successfully complete creation of a choice" do
            post1 = FactoryBot.create(:post,
            description: "AAAAA",
            user_id: User.all.take.id,
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
                'images', 'harry.jpg'), 'image/jpg')
            )
            #post :create, params: {post: Post.all.take}
            choice_param = FactoryBot.attributes_for(:choice) 
            choice_param[:topic_id] = Post.all.take.id
            expect{
                post :create, params: {choice: choice_param}
            }.to change(Choice, :count).by(1)
            
        end
        
        it "redirects to new choice page" do
            post1 = FactoryBot.create(:post,
            description: "AAAAA",
            user_id: User.all.take.id,
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
                'images', 'harry.jpg'), 'image/jpg')
            )
            #post :create, params: {post: Post.all.take}
            choice_param = FactoryBot.attributes_for(:choice) 
            choice_param[:topic_id] = Post.all.take.id
            expect(
                post :create, params: {choice: choice_param}
            ).to redirect_to(root_path)
            
        end
        
        it "fail to create a choice when we do not upload images" do
            Choice.new
            post2 = FactoryBot.create(:post,
            description: "AAAAA",
            user_id: User.all.take.id,
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
                'images', 'harry.jpg'), 'image/jpg')
            )
            #post :create, params: {post: Post.all.take}
            choice_param = FactoryBot.attributes_for(:choice) 
            choice_param[:topic_id] = Post.all.take.id
            choice_param[:images] = nil
            expect {
                post :create, params: {choice: choice_param}
            }.to raise_error
        end
        
    end
    #https://stackoverflow.com/questions/55141549/attaching-activestorage-files-in-factorybot
    describe "GET show" do
        it "successfully request the page" do
            post1 = FactoryBot.create(:post,
            description: "AAAAA",
            user_id: User.all.take.id,
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
                'images', 'harry.jpg'), 'image/jpg')
            )
            choice_param = FactoryBot.attributes_for(:choice) 
            choice_param[:topic_id] = Post.all.take.id
            post :create, params: {choice: choice_param}
            
            get :show, params: {id: Choice.all.take.id}
            expect(response.status).to eq(200)          
        end
        
        it "renders the show template" do
            post1 = FactoryBot.create(:post,
            description: "AAAAA",
            user_id: User.all.take.id,
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
                'images', 'harry.jpg'), 'image/jpg')
            )
            choice_param = FactoryBot.attributes_for(:choice) 
            choice_param[:topic_id] = Post.all.take.id
            post :create, params: {choice: choice_param}
            
            get :show, params: {id: Choice.all.take.id}
            response.should render_template :show          
        end
        
    end
    
    
    
    describe "upvote" do
        it "redirect to the home page" do
            post1 = FactoryBot.create(:post,
            description: "AAAAA",
            user_id: User.all.take.id,
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
                'images', 'harry.jpg'), 'image/jpg')
            )
            
            choice1 = FactoryBot.create(:choice,
            description: "MyString",
            topic_id: Post.all.take.id,
            images: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
                'images', 'harry.jpg'), 'image/jpg')
            )
            post :upvote, params: {id: Choice.all.take.id}
            expect(response).to redirect_to(root_path)          
        end
        
        #Since there are constant values assigned in the post page, this function will be covered in the next iteration
        #it "adds one to the upvote value" do
        #   
        #end

    end


end