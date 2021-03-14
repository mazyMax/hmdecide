Given /the following users exist/ do |users_table|
  User.destroy_all
  users_table.hashes.each do |user|   
    User.create!(user)
  end

end
