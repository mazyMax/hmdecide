Feature: Log in
	AS a new visitor
	If I have an account, then I can get access to vote page and profile page
    
    After I logged in, I can log out
    
Background: 
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |

# delete the drop down menu will fix this scenario
Scenario: Log in with an existing account
	Given I am on the home page
    Then I should not see "Log Out"
    Then I should not see "Update Account"
    Then I should not see "Profile"
	Then I follow "Log In"
	Then I should see "Log in"
	Then I should see "Email"
	Then I should see "Password"
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I should be on the home page
    Then I should see "Signed in successfully."
    Then I should see "Update Account"
    Then I should see "Profile"

Scenario: Log in using an email that are not registered before
    Given I am on the log in page
    And I fill in "Email" with "12351235@qq.com"
    And I fill in "Password" with "4156GOGOGO"
    And I press "Log in"
    Then I should see "Invalid Email or password."
    
Scenario: Log in using an email using wrong password
    Given I am on the log in page
    And I fill in "Email" with "728977862@qq.com"
    And I fill in "Password" with "asdfasdfas"
    And I press "Log in"
    Then I should see "Invalid Email or password."
    
Scenario: Redirect to sign up
    Given I am on the log in page
    Then I should see "Sign up"
    Then I follow "Sign up"
    Then I should be on the sign up page
    
Scenario: Redirect to forget password
    Given I am on the log in page
    Then I should see "Forgot your password?"
    Then I follow "Forgot your password?"
    Then I should be on the forget password page
    
Scenario: Log out
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I should be on the home page
    Then I should see "Signed in successfully."
    
    Then I should not see "Sign Up"
    Then I should not see "Log In"
    Then I press "Log Out"
    Then I should be on the home page
    Then I should see "Signed out successfully."
    Then I should see "Log In"
    Then I should see "Sign Up"
    And I should not see "Log Out"
    And I should not see "Update Account"
    And I should not see "Profile"
# delete the drop down menu will fix this scenario
