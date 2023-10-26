Feature: Updating Tasks

    Scenario: Unsuccessful todo list update
        Given there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        And I update the challenge task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
            | New Task 3   |
        Then I should be redirected to the details page for "Temp Challenge 1"
        Then I should see a flash notice with the message "Challenge has already started. You cannot edit to do list."

    Scenario: Successful todo list update
        Given there is a challenge "Temp Challenge 2" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 2 | 2024-10-02  | 2024-10-31  | Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 2"
        And I update the challenge task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
            | New Task 3   |
        Then I should be redirected to the edit page for "Temp Challenge 2"
        Then I should see a flash notice with the message "The Generic Todo List was successfully updated"

        Scenario: Successful todo list update with new tasks
        Given there is a challenge "Temp Challenge 2" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 2 | 2024-10-02  | 2024-10-31  | Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 2"
        And I click on "Add Task"
        And I update the challenge task list with the following tasks:
            | tasks        |
            | New Task 5   |
            | New Task 6   |
            | New Task 7   |
        Then I should be redirected to the edit page for "Temp Challenge 2"
        Then I should see a flash notice with the message "The Generic Todo List was successfully updated"
