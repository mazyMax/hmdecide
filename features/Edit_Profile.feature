Feature: I can edit my profile
Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |    

# both scenarios can be fixed by deleting the drop down menu

Scenario: Change personal information
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    Then I follow "Profile"
    Then I follow "Edit Profile"
    Then I should see "Change Password"
    And I should see "Authorized Applications"
    And I should see "Email and SMS"
    And I should see "Manage Contacts"
    And I should see "Privacy and Security"
    
    And I should see "Change Profile Photo"
    And I should see "Name"
    And I should see "Email"
    And I should see "Username"
    And I should see "Website"
    And I should see "Bio"
    And I should see "Phone"
    And I should see "Gender"
    
    # change a profile photo
    Then I fill in "Name" with "Yanhao"
    And I fill in "Username" with "CrazyPenguin"
    And I fill in "Website" with "https://pythex.org/"
    And I fill in "Bio" with "Hello World"
    And I fill in "Phone" with "3107760015"
    And I fill in "Gender" with "Male"
    Then I press "Submit!"
    Then I should be redirected to the profile page of "728977862@qq.com"
    # the email is not changed