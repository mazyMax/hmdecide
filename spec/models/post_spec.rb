require 'rails_helper'
def clean_db
    Choice.destroy_all
    Post.destroy_all
    User.destroy_all
end
describe "Post" do
    
 #   "12345"=>{"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpg')}
    
    describe "Corresponding_Choices" do
        it "search the corresponding choices by post_id" do

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

            post_id = Post.all.take.id
            correct_choice_id = Choice.all.take.id
            expect (Post.Corresponding_Choices(post_id).take.id == correct_choice_id)
        end
    end
    
    
    describe "Corresponding_Posts" do
        it "search the corresponding posts by user_id" do

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

            user_id = User.all.take.id
            correct_post_id = Post.all.take.id
            expect (Post.Corresponding_Posts(user_id).take.id == correct_post_id)
        end
    end
    
end