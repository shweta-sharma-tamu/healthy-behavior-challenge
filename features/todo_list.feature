# features/todo_list.feature

Feature: Manage Daily To-Do List
  As a user
  I want to manage my daily to-do list
  So that I can keep track of my tasks

  Scenario: Viewing the To-Do List
    Given I am logged in
    When I click on link "My TODO List"
    Then I should be on the todo list page
    And I should be able to see "Daily To-Do List"
    And I should be able to see "Date:"

  Scenario: Updating the To-Do List
    Given I am logged in
    When I click on link "My TODO List"
    And I check the "exercise" checkbox for a task
    And I click button "Mark as Completed"
    Then I should be able to see a notice "Tasks have been updated"
