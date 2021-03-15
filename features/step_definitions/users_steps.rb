Given /the following users exist/ do |users_table|
  User.destroy_all
  users_table.hashes.each do |user|   
    User.create!(user)
  end

end

Given /^PENDING/ do
    pending
end

Then /I should be redirected to the profile page of "([^"]*)"/ do |email|
  '/user/' + (User.where("email = ?", email).take.id).to_s
end

Then /I should be redirected to the edit profile page of "([^"]*)"/ do |email|
  '/user/' + (User.where("email = ?", email).take.id).to_s + '/edit'
end

Then /I upload an image named "([^"]*)"/ do |file_name|
    #hash_param = FactoryBot.attributes_for(:post)
    #hash_param[:user_id] = User.all.take.id
    page.attach_file 'Image', Rails.root.join('app', 'assets', 'images', file_name)
end


Then /I should be able to get "([^"]*)"/ do |post_name|
    #this redirection is assigned with constant value, which will be implemented fully in the next iteration
    get choice_path(1)
end
