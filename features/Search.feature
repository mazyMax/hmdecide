Feature: After a user logged in, this user will get the access to post votes

Background:
    Given the following users exist:
    | email              | password           |created_at         |updated_at          |
    | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |

#    Given the following posts exist:
#    | description | user_id   | post_id |created_at         |updated_at          |
#    | what food   | 1         | 1       |2021-03-13 11:04:06|2021-03-13 11:04:06 |
    
#    Given the following choices exist:
#    | description   | user_id   | post_id | choice_id | count |created_at         |updated_at          |
#    | whatfood_c1   | 1         | 1       | 1         | 0     |2021-03-13 11:04:06|2021-03-13 11:04:06 |
#    | whatfood_c2   | 1         | 1       | 2         | 0     |2021-03-13 11:04:06|2021-03-13 11:04:06 |
#    | whatfood_c3   | 1         | 1       | 3         | 0     |2021-03-13 11:04:06|2021-03-13 11:04:06 |
   
#    Given I am on the log in page
#	And I fill in "Email" with "728977862@qq.com"
#	And I fill in "Password" with "4156GOGOGO"
#	And I press "Log in"
#    Then I follow "New Vote"
#    Then I should be on the post_vote page
#    Then I fill in "Description" with "what food"
#    Then I follow "Add Choices"
#    And I upload images named "chicken.jpg, steak.jpg, chicken.jpg, pizza.jpg"
#    #And I upload an image named "steak.jpg"
#    #And I upload an image named "chicken.jpg"
#    And I press "Create Vote"
#    Then I should be on the home page
    
#Scenario: search an existing keyword for discription
#    Given I am on the home page
#    Then I should see "Search"
#    And I should see "Submit"
#    Then I fill in "Search" with "food"
#    And I press "Submit"
#    Then I should see "what food"
    
#Scenario: search a keyword that does not exist for discription
#    Given I am on the home page
#    Then I should see "Search"
#    And I should see "Submit"
#    Then I fill in "Search" with "university"
#    And I press "Submit"
#    Then I should not see "university"
#    And I should not see "what food"