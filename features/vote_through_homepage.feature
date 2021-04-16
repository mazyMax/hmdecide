Feature: When I finish logging in, I can select the posts through home page to vote
Background:
    # User warden to log in , information as follows
    # | email              | password           |created_at         |updated_at          |
    # | 728977862@qq.com   | 4156GOGOGO         |2021-03-13 11:04:06|2021-03-13 11:04:06 |
      
    Given I logged in using "728977862@qq.com"

Scenario: Upvote a post
    Given One post named AAAA exist
    Then I visit the posts page
    # Then I should see "Vote"
    Given I am on the home page
    Then I click the image
    Then I click Vote
