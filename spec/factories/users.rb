require 'factory_bot_rails'
FactoryBot.define do
  factory :user do
    email {'728977862@qq.com'} # default values
    password {'4156GOGOGO'}
    created_at {10.years.ago}
    updated_at {10.years.ago}
  end
end