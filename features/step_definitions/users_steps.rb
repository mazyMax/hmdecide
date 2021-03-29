Given /the following users exist/ do |users_table|
  Post.destroy_all
  Choice.destroy_all
  User.destroy_all
    
  users_table.hashes.each do |user|   
    User.create!(user)
  end
end

Given /the following posts exist/ do |posts_table|
  Post.destroy_all
  Choice.destroy_all
  User.destroy_all
    
  posts_table.hashes.each do |post|   
    Post.create!(post)
  end
end

Given /the following choices exist/ do |choices_table|
  Post.destroy_all
  Choice.destroy_all
  User.destroy_all
    
  choices_table.hashes.each do |choice|   
    Choice.create!(choice)
  end
end





Given /^PENDING/ do
    pending
end

#Given /post without image exist/ do
#     hash_param = {}
#     hash_param[:description] = "AAAAA"
#     hash_param[:user_id] = User.where("email = ?", "728977862@qq.com").take.id

#     hash_param[:image] = ActionDispatch::Http::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'))
#     images_param = {"images"=>Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpg')}
#     images_list_param = {"12345"=>images_param}       
#     hash_param["choices_attributes"] = images_list_param
#     
#     post posts_path(post: hash_param)
# end
Given /One post named AAAA exist/ do

    post_true_params = {"description": "AAAA", "user_id": User.where("Email = ?", "728977862@qq.com").take.id}
        post_true_params[:image] = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpg')
        @post = Post.new(post_true_params)
        @post.save
    choice_params = {
        "post_id": Post.all.take.id,
        "user_id": User.where("Email = ?", "728977862@qq.com").take.id
    }
    choice_params[:images] = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'harry.jpg'), 'image/jpg')
    
    Choice.create(choice_params)

end

Then /I visit the posts page/ do
    get post_path(id: Post.all.take.id)
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
