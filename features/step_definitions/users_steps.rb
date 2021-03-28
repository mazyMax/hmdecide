Given /the following users exist/ do |users_table|
  User.destroy_all
  users_table.hashes.each do |user|   
    User.create!(user)
  end
end

Given /the following posts exist/ do |posts_table|
  Post.destroy_all
  posts_table.hashes.each do |post|   
    Post.create!(post)
  end
end

Given /the following choices exist/ do |choices_table|
  Choice.destroy_all
  choices_table.hashes.each do |choice|   
    Choice.create!(choice)
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

Then /I upload images named "([^"]*)"/ do |file_names|
    name_arr = file_names.split(", ")
    p = page.find("#post_image", visible: :all)
    #log(p.text)
    p.attach_file Rails.root.join('app', 'assets', 'images', name_arr[0])
    
    c1 = page.find("#choices_images", visible: :all)
    c1.attach_file Rails.root.join('app', 'assets', 'images', name_arr[1])
    
    #c2 = page.all('.nested-fields').last
    #log(c2.text)
    c2 = page.find("#post_choices_attributes", :text => /([^"]*)/, visible: :all)
    #c2 = page.find(temp, visible: :all)
    #find("img[src^='https://www.example.com/image']")
    
    c2.attach_file Rails.root.join('app', 'assets', 'images', name_arr[2])
    log(c2.text)
    #c2.attach_file Rails.root.join('app', 'assets', 'images', name_arr[2])
    #hash_param = FactoryBot.attributes_for(:post)
    #hash_param[:user_id] = User.all.take.id
    #file_names.split(", ").each { |file_name|
    #    page.attach_file 'Image', Rails.root.join('app', 'assets', 'images', file_name)
    #}
    #page.attach_file 'Images', [Rails.root.join('app', 'assets', 'images', name_arr[0]), Rails.root.join('app', 'assets', 'images', name_arr[1]), Rails.root.join('app', 'assets', 'images', name_arr[2])]
end

Then /I request "([^"]*)"/ do |post_name|
    #this redirection is assigned with constant value, which will be implemented fully in the next iteration
    get choice_path(1)
end

Then /I upvote for "([^"]*)"/ do |post_name|
    #this is also assigned with constant value, which will be implemented fully in the next iteration
    put like_choice_path(1)
end
