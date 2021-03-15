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
