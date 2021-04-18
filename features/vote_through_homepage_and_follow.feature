Feature: When I finish logging in, I can select the posts through home page to vote
Background:
    User.destroy_all
    # User warden to log in , information as follows
    # | email              | password           |created_at         |updated_at          |
    # | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |
      

@javascript
Scenario: upvote a post
    Given I login using "728977862@qq.com"
    Given I am on the home page
    And I follow "New Vote"
    Then I fill in "Description" with "what food"
    And I upload an image named "steak.jpg"
    Then I follow "Add Choices"
    And I upload "steak.jpg" in the nested form
    And I press "Create Vote"
    Then I should be on the home page
    Then I click the image
    Then I click Vote

@javascript
Scenario: follow user and I should be able to see the followers only post. Then I unfollow the user, and I should not be able to see the followers only post.
    Given I login using "728977862@qq.com"
    Given I am on the home page
    And I follow "New Vote"
    Then I fill in "Description" with "what food"
    And I upload an image named "steak.jpg"
    Then I follow "Add Choices"
    And I upload "steak.jpg" in the nested form
    And I initiate it with public
    And I press "Create Vote"
    Then I should be on the home page
    And I follow "New Vote"
    Then I fill in "Description" with "followers_only_test"
    And I upload an image named "steak.jpg"
    Then I follow "Add Choices"
    And I upload "steak.jpg" in the nested form
    And I press "Create Vote"
    Then I should be on the home page
    Given I logout
    Given I login using "12345678@qq.com"
    Given I am on the home page
    Then I click the image
    Then I click follow
    Given I am on the home page
    Then I should see "followers_only_test"
    Then I click the image
    Then I click unfollow
    Given I am on the home page
    Then I should not see "followers_only_test"
