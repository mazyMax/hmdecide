# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /^the home\s?page$/ then '/'
        
    when /^the sign up\s?page$/ then '/users/sign_up'
    
    when /^the log in\s?page$/ then '/users/sign_in'
        
    when /^the about\s?page$/ then '/home/about'
        
    when /^the post_vote\s?page$/ then '/posts/new'
        
    when /^the forget password\s?page$/ then '/users/password/new'
        
    when /^the forget password\s?page$/ then '/users/password'
        
    when /^the profile\s?page$/ then '/users/1'
        
    when /^the edit profile\s?page$/ then '/users/1/edit'
        
    when /^the choice\s?page$/ then '/choices/1'
        
    when /^the choice_upload\s?page$/ then '/choices/new'
        
    #when /^the signed in\s?page$/ then '/users/sign_in'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
