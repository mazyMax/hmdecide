Feature: After creating a vote, I am able to change the visibility of it, and I can sort them using different methods
Background:
   #  Given the following users exist:
   #  | email              | password           |created_at         |updated_at          |
   #  | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |

   # Given I am on the log in page
	# And I fill in "Email" with "728977862@qq.com"
	# And I fill in "Password" with "4156GOGOGO"
	# And I press "Log in"
   Given I logged in using "728977862@qq.com"

@javascript
Scenario: I am able to change visibility
   Given I am on the home page
   #And I accept the location alert
   And I follow "New Vote"
   Then I should be on the post_vote page
   Then I fill in "Description" with "what food"
   And I upload an image named "steak.jpg"
   Then I follow "Add Choices"
   And I upload "steak.jpg" in the nested form
   And I press "Create Vote"
   Then I should be on the home page
   And I should see "what food"
   Then I click the image
   Then I press "Change to public"
   Then I press "Change to private"
   Then I press "Change to followers only"
   Then I press "Close the Vote"
   Then I press "Delete the Vote"

@javascript
Scenario: I am able to sort using different methods when I enable the location access
   Given I am on the home page
   #And I accept the location alert
   And I follow "New Vote"
   Then I should be on the post_vote page
   Then I fill in "Description" with "what food"
   And I upload an image named "steak.jpg"
   Then I follow "Add Choices"
   And I upload "steak.jpg" in the nested form
   And I press "Create Vote"
   Then I should be on the home page
   And I should see "what food"
   Then I press "Nearby"
   Then I press "Following"
   Then I press "Popular"