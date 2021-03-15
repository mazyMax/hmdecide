require 'rails_helper'


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
    end
    
    describe "GET show" do
        it "show the choices that one user creates" do
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
    end
    
    
    
    

end

