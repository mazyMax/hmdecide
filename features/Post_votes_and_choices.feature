Feature: After a user logged in, this user will get the access to post votes


Background:
   #  Given the following users exist:
   #  | email              | password           |created_at         |updated_at          |
   #  | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |

   # Given I am on the log in page
	# And I fill in "Email" with "728977862@qq.com"
	# And I fill in "Password" with "4156GOGOGO"
	# And I press "Log in"
   Given I logged in using "728977862@qq.com"
    
#reference: https://gist.github.com/AbbyJonesDev/6855281
#https://stackoverflow.com/questions/3724487/rails-root-directory-path
#https://stackoverflow.com/questions/9667373/how-to-test-multiple-file-upload-using-cucumber-capybara
# https://www.it1352.com/790033.html

@javascript
Scenario: Post a new vote successfully, Firstly upload a vote, and then upload several choices for the vote, then go to see its details
   Given I am on the home page
#    And I accept the location alert
   And I follow "New Vote"
   Then I should be on the post_vote page
   Then I fill in "Description" with "what food"
   And I upload an image named "steak.jpg"
   Then I follow "Add Choices"
   And I upload "steak.jpg" in the nested form
   And I press "Create Vote"
   Then I should be on the home page
   And I should see "what food"

@javascript
Scenario: Post a private vote
   Given I am on the home page
#    And I accept the location alert
   And I follow "New Vote"
   Then I should be on the post_vote page
   Then I fill in "Description" with "what food"
   And I initiate it with private
   And I upload an image named "steak.jpg"
   Then I follow "Add Choices"
   And I upload "steak.jpg" in the nested form
   And I press "Create Vote"
   Then I should be on the home page
   And I should see "what food"
    
# Images are essential to create a vote
Scenario: Post a new vote without image, and it should fail
    Given I am on the post_vote page
    And I fill in "Description" with "Which book"
    And I press "Create Vote"
    Then I should see "Image can't be blank"

# Images are essential to create a vote
Scenario: Post a new vote without choices, and it should fail
    Given I am on the post_vote page
    And I fill in "Description" with "Which book"
    And I upload an image named "steak.jpg"
    And I press "Create Vote"
    Then I should see "Please upload your choices!"
    

