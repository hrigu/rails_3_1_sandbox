Feature: Manage Post
  In Order to manage Post I can see a list of all posts

  Scenario: Show the list of all posts
    Given two posts

    When I go to the posts page
    Then I see both posts

  Scenario: Show the details of all posts
    Given a post with title "hello"
    And a post with title "hi"
    And a post with title "wonderful"
    And I am on the posts page
    When I follow "show_hello"
    Then I see the details of the "hello" post