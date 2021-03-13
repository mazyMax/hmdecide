Feature: Log in
	AS a new visitor
	If I have an account, then I can get access to vote page and profile page
    
    After I logged in, I can log out
    
Background: 
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |


Scenario: Log in with an existing account
	Given I am on the home page
    Then I should not see "Log Out"
	Then I follow "Log In"
	Then I should see "Log in"
	Then I should see "Email"
	Then I should see "Password"
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I should be on the home page
    Then I should see "Signed in successfully."

#Log out这里写的不对，需要更改！！！！
Scenario: Log out 
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I should be on the home page
    Then I should see "Signed in successfully."
    Then I follow "Log Out"
    Then I should be on the home page
    Then I should see "Log In"
    And I should not see "Log Out"

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
    