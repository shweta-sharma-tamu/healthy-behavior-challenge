Feature: Challenges Controller

  Scenario: Create a new challenge with same tasks
    Given I am an instructor
    And I am on the new challenge page
    When I fill "Name" with "Sample Challenge"
    And I fill "Start Date" with "2023-10-10"
    And I fill "End Date" with "2023-10-20"
    And I fill in the task name field with "Task 1"
    And I press Create Challenge
    Then I should see "Challenge successfully created."

  Scenario: Create a new challenge
    Given I am an instructor
    And I am on the new challenge page
    When I fill "Name" with "Sample Challenge"
    And I fill "Start Date" with "2023-10-10"
    And I fill "End Date" with "2023-10-20"
    And I fill in the task name field with "Task 2"
    And I press Create Challenge
    Then I should see "Challenge successfully created."

  Scenario: Create a new challenge with start date greater than end date
    Given I am an instructor
    And I am on the new challenge page
    When I fill "Name" with "Sample Challenge"
    And I fill "Start Date" with "2023-10-30"
    And I fill "End Date" with "2023-10-20"
    And I fill in the task name field with "Task 2"
    And I press Create Challenge
    Then I should see "start date is greater than end date"

  Scenario: Attempt to create a challenge with an existing name
    Given I am an instructor and There exists a challenge "Existing Challenge"
    And I am on the new challenge page
    When I fill "Name" with "Existing Challenge"
    And I fill "Start Date" with "2023-10-10"
    And I fill "End Date" with "2023-10-20"
    And I press Create Challenge
    Then I should see "A challenge with the same name already exists."

  Scenario: Attempt to create a challenge without being an instructor
    Given I am not an instructor
    When I visit the new challenge page
    Then I should see "Welcome, User"

  # Add more scenarios for other controller actions as needed
