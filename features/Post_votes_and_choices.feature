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
#https://stackoverflow.com/questions/9667373/how-to-test-multiple-file-upload-using-cucumber-capybara


#now, we can only upload one image to our post, This problem will be fixed in the next iteration.
Scenario: Post a new vote successfully, Firstly upload a vote, and then upload several choices for the vote, then go to see its details
    Given I am on the home page
    And I follow "New Vote"
    Then I should be on the post_vote page
    Then I fill in "Description" with "what food"
    Then I follow "Add Choices"
    Then show me the page
    And I upload images named "chicken.jpg, steak.jpg, chicken.jpg, pizza.jpg"
    #And I upload an image named "steak.jpg"
    #And I upload an image named "chicken.jpg"
    #And I upload an image named "pizza.jpg"
    And I press "Create Vote"
    Then I should be on the home page
    And I can see "what food"
    
    
    

    
    
    
    
    
    
    
   
# Images are essential to create a vote
Scenario: Post a new vote without image, and it should fail
    Given I am on the post_vote page
    And I fill in "Description" with "Which book"
    And I press "Create Vote"
    Then I should see "Image can't be blank"
    
