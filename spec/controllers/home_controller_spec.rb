require 'rails_helper'
#reference https://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
describe HomeController do  
    describe "GET index" do
        it "generates the view of the page" do
            get :index
            response.should render_template :index
        end
    end
end