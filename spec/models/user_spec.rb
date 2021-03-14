require 'rails_helper'


describe "User" do
    User.new
    User.destroy_all 
    test1 = FactoryBot.create(:user,
        email: "728977862@qq.com", 
        password: "4156GOGOGO", 
        created_at: "2021-03-13 11:04:06",
        updated_at: "2021-03-13 11:04:06"
    )
    test2 = FactoryBot.create(:user,
        email: "1234567@qq.com", 
        password: "4156GOGOGO", 
        created_at: 10.years.ago,
        updated_at: 10.years.ago
    )
end