Feature: Updating Tasks

    Scenario: Successful task update
        Given there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2  |
        And I am logged in as Instructor
        When I visit the edit page for trainee "tempTrainee1" and challenge "Temp Challenge 1"
        And I update the task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
            | New Task 3   |
        Then I should be redirected to the edit page for "tempTrainee1" and "Temp Challenge 1"
