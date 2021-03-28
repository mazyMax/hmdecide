require 'rails_helper'
#reference https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
describe HomeController do
    Post.destroy_all
    Choice.destroy_all
    User.destroy_all
    describe "GET index" do
        it "successfully request the page" do
            get :index
            expect(response.status).to eq(200)
        end
        
        it "renders the show template" do
            get :index
            response.should render_template :index
        end
    end
end