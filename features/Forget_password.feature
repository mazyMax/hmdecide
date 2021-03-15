Feature: I can reset my password
Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |    
    
Scenario: Redirect to sign up
    Given I am on the forget password page
    Then I should see "Sign up"
    Then I follow "Sign up"
    Then I should be on the sign up page

Scenario: Redirect to log in
    Given I am on the forget password page
    Then I should see "Log in"
    Then I follow "Log in"
    Then I should be on the log in page

Scenario: Non-existing email is used
    Given I am on the forget password page
    Then I should see "Forgot your password?"
    Then I should see "Email"
    And I fill in "Email" with "666666@qq.com"
    And I press "Send me reset password instructions"
    Then I should see "1 error prohibited this user from being saved:"
    Then I should see "Email not found"
    
Scenario: No email is used
    Given I am on the forget password page
    Then I should see "Forgot your password?"
    Then I should see "Email"
    And I press "Send me reset password instructions"
    Then I should see "1 error prohibited this user from being saved:"
    Then I should see "Email can't be blank"
    
# reference: http://www.databasically.com/2011/02/02/mark-a-scenario-in-cucumber-as-pending
#not implemented yet, this will be covered in iteration 2
#Scenario: Existing email is used(not implemented yet)
#    Given PENDING
#    Given I am on the forget password page
#    Then I should see "Forgot your password?"
#    Then I should see "Email"
#    And I fill in "Email" with "728977862@qq.com"
#    And I press "Send me reset password instructions"
#    And I shoule see "You will receive an email with instructions on how to reset your password in a few minutes."
#    And I should be on the log in page
    
# check invalid email address (may not necessary)