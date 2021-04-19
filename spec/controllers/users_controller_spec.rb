require 'rails_helper'
#reference https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html

def clean_db
    Choice.destroy_all
    Post.destroy_all
    User.destroy_all
end

describe UsersController do
    # UsersController.new
    # PostsController.new
    # ChoicesController.new
    # Choice.destroy_all
    # Post.destroy_all
    # User.destroy_all
    # puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
    # puts User.all.take.id

    # test2 = FactoryBot.create(:user,
    #     email: "1234567@qq.com", 
    #     password: "4156GOGOGO",
    #     created_at: "2021-03-13 11:04:06",
    #     updated_at: "2021-03-13 11:04:06"
    # )

    # test1 = FactoryBot.create(:user,
    #     email: "728977862@qq.com", 
    #     password: "4156GOGOGO", 
    #     created_at: "2021-03-13 11:04:06",
    #     updated_at: "2021-03-13 11:04:06"
    # )
    # puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
    # puts User.all.take.email
    



    # https://stackoverflow.com/questions/39189748/how-to-expect-render-template-error
    describe "Get edit" do

        it "successfully request the page" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            puts "editediteditediteditediteditediteditediteditediteditediteditediteditediteditediteditediteditedit"
            puts User.all.take.email
            puts User.where("email = ?", "728977862@qq.com").take.id
            get :edit, params: {id: User.where("email = ?", "728977862@qq.com").take.id}
            expect(response.status).to eq(200) 

        end
        
        it "renders the edit template" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            get :edit, params: {id: User.where("email = ?", "728977862@qq.com").take.id}
            response.should render_template :edit 

        end
        
    end
    
    describe "PUT update" do
        it "should update the information about one user" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            #reference: https://stackoverflow.com/questions/24522294/rspec-how-to-stub-inherited-method-current-user-w-o-devise
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:user, email:"1234567@qq.com")
            puts "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
            puts User.all.take.email
            id_param = User.all.take.id
            put :update, params:{
                id: id_param,
                user: hash_param
            }
            expect (User.all.take.email == "1234567@qq.com")

        end
    end


    describe "PUT follow" do
        it "follow one user" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            test2 = FactoryBot.create(:user,
                email: "1234567@qq.com", 
                password: "4156GOGOGO",
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            #reference: https://stackoverflow.com/questions/24522294/rspec-how-to-stub-inherited-method-current-user-w-o-devise
            u1 = User.where("email = ?", "728977862@qq.com").take
            u2 = User.where("email = ?", "1234567@qq.com").take
            put :follow, params:{
                id: u1.id.to_s + "/" + u2.id.to_s
            }
            # expect (User.all.take.email == "1234567@qq.com")

        end
    end

    describe "PUT follow" do
        it "unfollow one user" do
            clean_db
            test1 = FactoryBot.create(:user,
                email: "728977862@qq.com", 
                password: "4156GOGOGO", 
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            test2 = FactoryBot.create(:user,
                email: "1234567@qq.com", 
                password: "4156GOGOGO",
                created_at: "2021-03-13 11:04:06",
                updated_at: "2021-03-13 11:04:06"
            )

            #reference: https://stackoverflow.com/questions/24522294/rspec-how-to-stub-inherited-method-current-user-w-o-devise
            u1 = User.where("email = ?", "728977862@qq.com").take
            u2 = User.where("email = ?", "1234567@qq.com").take
            put :unfollow, params:{
                id: u1.id.to_s + "/" + u2.id.to_s
            }
            # expect (User.all.take.email == "1234567@qq.com")

        end
    end



end
   