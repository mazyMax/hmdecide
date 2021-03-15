#https://stackoverflow.com/questions/55141549/attaching-activestorage-files-in-factorybot
FactoryBot.define do
  factory :choice do
    description { "MyString" }
    images {
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 
            'images', 'harry.jpg'), 'image/jpg')
    }
    topic_id { '1' }
  end
end
