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

Given /"([^"]*)" create a post named "([^"]*)"/ do |email,name|

    post_true_params = {"description": name, "visibility": "public", "location": "37.090240,-95.712891", "user_id": User.where("Email = ?", email).take.id}
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

#https://github.com/teamcapybara/capybara/issues/2155
Then /I upload an image named "([^"]*)"/ do |file_name|
    #path should change when testing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    file_name = "D:\\SE_proj\\iter3_final\\hmdecide\\app\\assets\\images\\" + file_name
    page.attach_file 'Image', file_name
    # page.attach_file 'Image', Rails.root.join('app', 'assets', 'images', file_name)
    # file_name = '/app/assets/images/' + file_name
end

# https://www.rubydoc.info/github/teamcapybara/capybara/Capybara/Node/Actions#attach_file-instance_method
# https://stackoverflow.com/questions/37477426/capybara-match-element-id-with-regex
Then /I upload "([^"]*)" in the nested form/ do |file_name|
    #path should change when testing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    file_name = "D:\\SE_proj\\iter3_final\\hmdecide\\app\\assets\\images\\" + file_name
    page.all('input[id^="post_choices_attributes_"]').each do |el|
      el.attach_file file_name
    end  
end


Then /I request "([^"]*)"/ do |post_name|
    #this redirection is assigned with constant value, which will be implemented fully in the next iteration
    get choice_path(1)
end

Then /I upvote for "([^"]*)"/ do |post_name|
    #this is also assigned with constant value, which will be implemented fully in the next iteration
    put like_choice_path(1)
end

Then /I click the image/ do 
    #this is also assigned with constant value, which will be implemented fully in the next iteration
    # page.find("img").click
    find(:xpath, "/html/body/div/div[3]/div[1]/a").click
end

Then /I click follow/ do 
  #this is also assigned with constant value, which will be implemented fully in the next iteration
  find(:xpath, "/html/body/div/div[4]/form[1]/button").click
end

Then /I click unfollow/ do 
  #this is also assigned with constant value, which will be implemented fully in the next iteration
  find(:xpath, "/html/body/div/div[4]/form[2]/button").click
end

Then /I click Vote/ do 
  find(:xpath, "/html/body/div/div[3]/div[2]/form/button").click
end

Then /I search "([^"]*)"/ do |value|
  field = find(:xpath, "//*[@id=\"search\"]").set(value)
end

Then /I input to Hashtag using "([^"]*)"/ do |name|
  field = find(:xpath, "//*[@id=\"post_hash_tags\"]").set(name)
end

Then /I set existingtime with "([^"]*)"/ do |minute|
  field = find(:xpath, "//*[@id=\"post_existingtime\"]").set(minute)
end

Then /I sort it using distance/ do
  # get :index, params: {home: {"location"=>"37.090240,-95.712891", "controller"=>"home", "action"=>"index"}}
  # get root_path(home: {"location"=>"37.090240,-95.712891"})
  get root_path({"location"=>"37.090240,-95.712891"})
end

Given /I logged in using "728977862@qq.com"/ do
  # https://github.com/nbudin/devise_cas_authenticatable/issues/25
  @current_user = User.create({
    email: "728977862@qq.com", 
    password: "4156GOGOGO",
    created_at: "2021-03-13 11:04:06",
    updated_at: "2021-03-13 11:04:06"}
  )
  login_as(@current_user, :scope => "user")
end

Given /I logout/ do
  find(:xpath, "//*[@id=\"bs-example-navbar-collapse-1\"]/ul/li[3]/a").click
end
# https://gist.github.com/leshill/870866
# Then /I accept the location alert/ do 
#   alert = page.driver.browser.switch_to.alert
#   alert.send("Allow Location Access")
# end

Then /I initiate it with public/ do
  find(:xpath, "//*[@id=\"post_visibility_public\"]").click
end

Then /I initiate it with private/ do
  find(:xpath, "//*[@id=\"post_visibility_private\"]").click
end

Given /I login using "([^"]*)"/ do |email|
  login(email)

end

Given /^I wait for (\d+) seconds?$/ do |n|
  sleep(n.to_i)
end