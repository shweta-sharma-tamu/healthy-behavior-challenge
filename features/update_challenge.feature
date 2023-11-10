Feature: Updating Challenge

    Scenario: Successful challenge update for future challenge
        Given there is a challenge "Temp Challenge 2" with the trainee "tempTrainee2" with the following details:
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
        Then I should see a flash notice with the message "Challenge was successfully updated"

    Scenario: Successful challenge update for ongoing challenge
        Given there is a challenge "Temp Challenge 3" with the trainee "tempTrainee3" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 3 | 2023-10-02  | 2024-10-31  | Task 6, Task 7  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 3"
        And I update the challenge task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
            | New Task 3   |
        Then I should be redirected to the edit page for "Temp Challenge 3"
        Then I should see a flash notice with the message "Challenge was successfully updated"

    Scenario: Successful challenge update with new tasks
        Given there is a challenge "Temp Challenge 2" with the trainee "tempTrainee4" with the following details:
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
        Then I should see a flash notice with the message "Challenge was successfully updated"

    Scenario: Unsuccessful challenge update for previous challenge
        Given there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2023-10-02  | 2023-10-25  | Task 1, Task 2  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        And I update the challenge task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
            | New Task 3   |
        Then I should be redirected to the details page for "Temp Challenge 1"
        Then I should see a flash notice with the message "Challenge has already ended. You cannot edit it"

    Scenario: Unsuccessful challenge update with start date greater than end date
        Given there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2  |
        And I am logged in as Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        And I select the end date as "2024-10-01"
        And I update the challenge task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
        Then I should be redirected to the edit page for "Temp Challenge 1"
        Then I should see a flash notice with the message "Start date cannot exceed end date"

    Scenario: Unsuccessful challenge update with new start date greater than end date
        Given today is "2024-10-31"
        And there is a challenge "Temp Challenge 1" with the trainee "tempTrainee1" with the following details:
            | name             | startDate   | endDate     | tasks           |
            | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2  |
        And I am logged in as Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        And I select the start date as "2024-10-31"
        And I update the challenge task list with the following tasks:
            | tasks        |
            | New Task 1   |
            | New Task 2   |
        Then I should be redirected to the edit page for "Temp Challenge 1"
        Then I should see a flash notice with the message "Challenge has already started. List will be updated from tomorrow and the start date exceeds the end date"