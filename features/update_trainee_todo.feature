Feature: Updating Tasks

    Scenario: Successful trainee todo list tasks update
        Given there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2  |
        And I am logged in as Instructor
        When I visit the edit page for trainee "tempTrainee1" and challenge "Temp Challenge 1"
        And I update the task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
        Then I should be redirected to the edit page for "tempTrainee1" and "Temp Challenge 1"
        And I should see a flash notice with the message "Tasks successfully updated."

    Scenario: Unsuccessful trainee todo list tasks update with start date as today
        Given there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2  |
        And I am logged in as Instructor
        When I visit the edit page for trainee "tempTrainee1" and challenge "Temp Challenge 1"
        And I update the task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
        Then I should be redirected to the edit page for "tempTrainee1" and "Temp Challenge 1"
        And I should see a flash notice with the message "Challenge has already started! Choose a start date from tomorrow onwards."

    Scenario: Unsuccessful trainee todo list tasks update with end date out of actual challenge end date
        Given there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2  |
        And I am logged in as Instructor
        When I visit the edit page for trainee "tempTrainee1" and challenge "Temp Challenge 1"
        And I select the end date as "2023-11-3"
        And I update the task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
        Then I should be redirected to the edit page for "tempTrainee1" and "Temp Challenge 1"
        And I should see a flash notice with the message "Date range must be within the challenge's start and end dates."

    Scenario: Successful trainee todo list tasks update with new tasks
        Given there is a challenge "Temp Challenge 2" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 2 | 2024-10-02  | 2024-10-31  | Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for trainee "tempTrainee1" and challenge "Temp Challenge 2"
        And I click on "Add Task"
        And I update the task list with the following tasks:
            | tasks        |
            | New Task 5   |
            | New Task 6   |
        Then I should be redirected to the edit page for "tempTrainee1" and "Temp Challenge 2"
        And I should see a flash notice with the message "Tasks successfully updated."
