require 'factory_bot_rails'
#https://stackoverflow.com/questions/55141549/attaching-activestorage-files-in-factorybot
FactoryBot.define do
  factory :post do
    description {'AAAAA'} # default values
    user_id {'1'}
    image {
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
            'images', 'harry.jpg'), 'image/jpg')
    }
  end
end

