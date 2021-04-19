require 'rails_helper'
def clean_db
    Choice.destroy_all
    Post.destroy_all
    User.destroy_all
end

#reference https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
describe ChoicesController do
    # PostsController.new
    # ChoicesController.new
    # Post.destroy_all
    # Choice.destroy_all
    # User.destroy_all
    


    # #https://stackoverflow.com/questions/55141549/attaching-activestorage-files-in-factorybot
    # describe "GET show" do
    #     it "successfully request the page" do
            
    #         post_test = FactoryBot.create(:post,
    #         user_id: User.all.take.id
    #         )  
    #         choice_param = FactoryBot.attributes_for(:choice) 
    #         choice_param[:post_id] = Post.all.take.id
    #         choice_param[:user_id] = User.all.take.id
            
    #         get :show, params: {id: Choice.all.take.id}
    #         expect(response.status).to eq(200)          
    #     end
        
    #     it "renders the show template" do
    #         post_test = FactoryBot.create(:post,
    #         user_id: User.all.take.id
    #         )  
    #         choice_param = FactoryBot.attributes_for(:choice) 
    #         choice_param[:post_id] = Post.all.take.id
    #         choice_param[:user_id] = User.all.take.id
            
    #         get :show, params: {id: Choice.all.take.id}
    #         response.should render_template :show          
    #     end
        
    # end

    
    
    describe "upvote" do
        it "redirect to the home page" do
            
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            allow(controller).to receive(:current_user).and_return(User.all.take)
            post_test = FactoryBot.create(:post,
            user_id: User.all.take.id
            )
            choice_test = FactoryBot.create(:choice,
            post_id: Post.all.take.id,
            user_id: User.all.take.id
            )
            
            post :upvote, params: {id: Choice.all.take.id}
            expect(response).to redirect_to(root_path)
        end
    end
    
    # describe "POST create" do
    #     it "creates a new choice" do
    #         post_test = FactoryBot.create(:post,
    #         user_id: User.all.take.id
    #         )
            
    #         hash_param = {
    #             "description": "AAA",
    #             "images": Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpg'),
    #             "post_id": Post.all.take.id,
    #             "user_id": User.all.take.id
    #         }
            
    #         post :create, params: {choice: hash_param}
    #         expect { 
    #           post :create, params: {choice: hash_param}
    #         }.to change(Choice, :count).by(1)
            
    #     end
    # end
    

end