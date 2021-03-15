Given /the following users exist/ do |users_table|
  User.destroy_all
  users_table.hashes.each do |user|   
    User.create!(user)
  end

end

Then /I should be redirected to the profile page of "([^"]*)"/ do |email|
  '/user/' + (User.where("email = ?", email).take.id).to_s
end

Then /I should be redirected to the edit profile page of "([^"]*)"/ do |email|
  '/user/' + (User.where("email = ?", email).take.id).to_s + '/edit'
end

Then /I upload an image named "([^"]*)"/ do |file_name|
    hash_param = FactoryBot.attributes_for(:post)
    hash_param[:user_id] = User.all.take.id
    #Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', file_name), 'image/jpg')
    post :create, params: {post: hash_param}
end

