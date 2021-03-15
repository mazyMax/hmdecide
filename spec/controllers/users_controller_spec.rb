require 'rails_helper'
#reference https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html

describe UsersController do
    User.destroy_all
    UsersController.new
    test1 = FactoryBot.create(:user,
        email: "728977862@qq.com", 
        password: "4156GOGOGO",
        created_at: "2021-03-13 11:04:06",
        updated_at: "2021-03-13 11:04:06"
    )
    #unfinished!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    describe "edit function" do
        it "should get information about one ID" do
            get :edit, params: {id: User.where("email = ?", "728977862@qq.com").take.id}
        end
    end
    
    describe "PUT update" do
        it "should update the information about one user" do
            #reference: https://stackoverflow.com/questions/24522294/rspec-how-to-stub-inherited-method-current-user-w-o-devise
            allow(controller).to receive(:current_user).and_return(User.all.take)
            hash_param = FactoryBot.attributes_for(:user, email:"1234567@qq.com")
            id_param = User.all.take.id
            put :update, params:{
                id: id_param,
                user: hash_param
            }
            expect (User.all.take.email == "1234567@qq.com")
            
        end

    end

end
   