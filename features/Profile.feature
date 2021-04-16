Feature: I can visit a user's detailed profile
Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |    



Scenario: Visit the profile page
    Given I am on the log in page
    Then I should not see "Profile"
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I should see "Profile"
    Then I follow "Profile"
    And I should see "Edit Profile"


Scenario: Redirect to edit profile page
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I follow "Profile"
    And I follow "Edit Profile"
    Then I should be redirected to the edit profile page of "728977862@qq.com"
    
