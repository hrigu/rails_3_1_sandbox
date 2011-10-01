Feature: Manage Post
  In Order to manage Post I can see a list of all posts

  Scenario: Show the list of all posts
    Given two posts

    When I go to the posts page
    Then I see both posts