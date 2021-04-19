Feature: If I do not log in, I can press visibility sort buttons normally.

Background:
    User.destroy_all

@javascript
Scenario: When I do not log in, test visibility selection
    Given I login using "728977862@qq.com"
    Given "728977862@qq.com" create a post named "fl_t"
    Given I logout
    Given I am on the home page
    Then I press "Nearby"
    Then I press "Following"
    Then I press "Popular"
    Then I should see "fl_t"
