Feature: When I finish logging in, I can select the posts through home page to vote
Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |
      
    Given I am on the log in page
	And I fill in "Email" with "728977862@qq.com"
	And I fill in "Password" with "4156GOGOGO"
	And I press "Log in"
    And I follow "New Vote"
    Then I fill in "Description" with "what food"
    Then I follow "Add Choices"
    And I upload images named "chicken.jpg, steak.jpg, chicken.jpg, pizza.jpg"
    #And I upload an image named "steak.jpg"
    #And I upload an image named "chicken.jpg"
    #And I upload an image named "pizza.jpg"
    And I press "Create Vote"
    #this redirection is assigned with constant value, which will be implemented fully in the next iteration
    #And I request "what food"
    Then I should be on the home page
    And I can see "what food"
    
Scenario: Upvote a post
    Given I am on the choice page
    #Then I request "the first post"
    Then I should see "Vote"
    Then I upvote for "what food"
    Then I should be on the home page
    