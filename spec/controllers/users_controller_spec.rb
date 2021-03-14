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
    
#    describe "update function" do
#        it "should update the information about one ID" do
#                put :update, id: @contact, 
#                user: FactoryBot.attributes_for(
#                    :contact, 
#                    firstname: "Larry", 
#                    lastname: "Smith"
#                )
#                @contact.reload
#                @contact.firstname.should eq("Larry")
#                @contact.lastname.should eq("Smith")
#        end
#        it "should redirect to the current user page" do
#            put :update, id: @contact, contact: Factory.attributes_for(:contact)
#            response.should redirect_to @contact
#        end
#    end

end
   