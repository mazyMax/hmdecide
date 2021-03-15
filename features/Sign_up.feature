Feature: Sign up
	AS a new visitor
	I can use email that has not been registered before to sign up for a new account

Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |


Scenario: Sign up for a new account with correct information
    Given I am on the home page
    And I follow "Sign Up"
    Then I should see "Password confirmation"
    And I fill in "Email" with "1234567@qq.com"
    And I fill in "Password" with "4156GOGOGO"
    And I fill in "Password confirmation" with "4156GOGOGO"
    And I press "Sign up"
    Then I should be on the home page 
    Then I should see "Welcome! You have signed up successfully."

Scenario: Sign up for a new account using a registered email
    Given I am on the sign up page
    And I fill in "Email" with "728977862@qq.com"
    And I fill in "Password" with "asdfasdfasd"
    And I fill in "Password confirmation" with "asdfasdfasd"
    And I press "Sign up"
    Then I should see "Email has already been taken"
    
Scenario: Sign up for a new account without typing in password
    Given I am on the sign up page
    And I fill in "Email" with "1234567@qq.com"
    And I press "Sign up"
    Then I should see "Password can't be blank"
    
Scenario: Sign up for a new account with incorrect form of password
    Given I am on the sign up page
    And I fill in "Email" with "1234567@qq.com"
    And I fill in "Password" with "4156"
    And I fill in "Password confirmation" with "4156"
    And I press "Sign up"
    Then I should see "Password is too short (minimum is 6 characters)"
    
Scenario: Sign up for a new account with unmatched password confirmation
    Given I am on the sign up page
    And I fill in "Email" with "14114@qq.com"
    And I fill in "Password" with "4156GOGOGO"
    And I fill in "Password confirmation" with "4156"
    And I press "Sign up"
    Then I should see "Password confirmation doesn't match Password"
    
Scenario: Redirect to log in
    Given I am on the sign up page
    Then I should see "Log in"
    Then I follow "Log in"
    Then I should be on the log in page