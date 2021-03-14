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
    
Scenario: Existing email is used
    Given I am on the forget password page
    Then I should see "Forgot your password?"
    Then I should see "Email"
    And I fill in "Email" with "728977862@qq.com"
    And I press "Send me reset password instructions"
    And I shoule see "You will receive an email with instructions on how to reset your password in a few minutes."
    # this should be filled after the logout function is finished
    # something like Then I can see "instruction is sent."
    # current bug will be fixed once the link of this button is added
    
# check invalid email address
Scenario: Invalid email is used