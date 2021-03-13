Feature: After a user logged in, this user will get the access to post votes

Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |

    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    
#reference: https://gist.github.com/AbbyJonesDev/6855281
#https://stackoverflow.com/questions/3724487/rails-root-directory-path
Scenario: Post a new vote successfully
    Given I am on the home page
    And I follow "New Vote"
    Then I should be on the post_vote page
    Then I fill in "Description" with "Which book"
    And I upload an image named "harry.jpg"
    And I press "Create Vote"
    Then I should be on the home page
    And I should see "Which book"
    And I should see "harry.jpg"

Scenario: Post a new vote without image
    Given I am on the post_vote page
    And I fill in "Description" with "Which book"
    And I press "Create Vote"
    Then I should be on the post_vote page
    And I should see "can't be blank"

Scenario: Post a new vote without Description
    Given I am on the post_vote page
    And I upload a image named "harry.jpg"
    And I press "Create Vote"
    Then I should be on the post_vote page
    And I should see "Please upload images."