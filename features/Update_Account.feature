Feature: When I finish logging in, I can update my password or cancel my account
Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |    
    
Scenario: Update account after sign in successfully
    Given I am on the home page
    Then I should not see "Update Account"
	Then I follow "Log In"
	Then I should see "Log in"
	Then I should see "Email"
	Then I should see "Password"
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I should see "Update Account"
    Then I follow "Update Account"
	Then I should see "Edit User"
	Then I should see "Email"
	Then I should see "Password"
    Then I should see "Password confirmation"
    Then I should see "Current password"
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO!"
    And I fill in "Password confirmation" with "4156GOGOGO!"
    And I fill in "Current password" with "4156GOGOGO"
	And I press "Update"
    Then I should be on the home page
    Then I should see "Your account has been updated successfully."
    
Scenario: Cancel account
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I follow "Update Account"
	Then I should see "Cancel my account"
	And I press "Cancel my account"
    Then I should be on the home page
    Then I should see "Bye! Your account has been successfully cancelled. We hope to see you again soon."

Scenario: Update account with wrong current password
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I follow "Update Account"
    And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO!"
    And I fill in "Password confirmation" with "4156GOGOGO!"
    And I fill in "Current password" with "4156GO"
	And I press "Update"
    Then I should see "1 error prohibited this user from being saved:"
    Then I should see "Current password is invalid"
    
Scenario: Update account with new password that has length < 6
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I follow "Update Account"
    And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156"
    And I fill in "Password confirmation" with "4156"
    And I fill in "Current password" with "4156GOGOGO"
	And I press "Update"
    Then I should see "1 error prohibited this user from being saved:"
    Then I should see "Password is too short (minimum is 6 characters)"
    
Scenario: Update account with password that does not match confirmation
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I follow "Update Account"
    And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGO"
    And I fill in "Password confirmation" with "4156GO"
    And I fill in "Current password" with "4156GOGOGO"
	And I press "Update"
    Then I should see "1 error prohibited this user from being saved:"
    Then I should see "Password confirmation doesn't match Password"
    
Scenario: Back to the user
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I follow "Update Account"
    Then I should see "Back"
    Then I follow "Back"
    Then I should be on the home page