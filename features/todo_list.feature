# features/todo_list.feature

Feature: Manage Daily To-Do List
  As a user
  I want to manage my daily to-do list
  So that I can keep track of my tasks

  Scenario: Viewing the To-Do List
    Given I am logged in
    Then I should be on the todo list page
    And I should be able to see "Daily To-Do List"
    And I should be able to see "Date:"

  Scenario: Updating the To-Do List
    Given I am logged in
    And I check the "exercise" checkbox for a task
    And I click button "Mark as Completed"
    Then I should be able to see a notice "Tasks have been updated"

  Scenario: Viewing the To-Do List with a Date Selector
    Given I am logged in
    Then I should be on the todo list page
    And I should be able to see "Daily To-Do List"
    And I should see "Date:"
    And I should see a date selector
  
  Scenario: Trainee selects a previous date and views tasks
    Given I am logged in
    When I visit the Daily Todo List page
    And I select a previous date from the date selector
    And I click "Show Tasks" button
    Then I should see the Daily Todo List for the selected date

  Scenario: Updating the To-Do List without checking tasks
    Given I am logged in as different user
    And I click button "Mark as Completed"
    Then I should be able to see a notice "No Tasks"
    Then I click the "Sign Out" button
    Then I should be redirected to the home page
  
  Scenario: Trying to access To-Do List page without signing in 
    Given I am not logged in
    And I try to visit Daily To-Do List page
    Then I should be able to see a notice "You must be signed in to access this page."

  Scenario: If logged in as Instructor
    Given I am logged in as instructor
    And I try to visit Daily To-Do List page
    Then I should be able to see "Ongoing Challenges"

  Scenario: Viewing my progress for a challenge
    Given I am logged in
    And I click on link "View Progress"
    Then I should be redirected to view progress page for "challenge"

