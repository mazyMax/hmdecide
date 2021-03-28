#https://stackoverflow.com/questions/55141549/attaching-activestorage-files-in-factorybot
FactoryBot.define do
  factory :choice do
    post_id { '1' }
    user_id {'1'}
    created_at {"2021-03-28 07:12:11"}
    updated_at {"2021-03-28 07:12:16"}
    images {
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
            'images', 'harry.jpg'), 'image/jpg')
    }
  end
end

