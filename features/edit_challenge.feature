Feature: Edit Challenge
    As an Instructor
    I want to edit a challenge
    So that I can update it as needed

    Scenario: View edit challenge page
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        Then I should see the title "Edit Challenge: Temp Challenge 1"

    Scenario: View edit challenge page for Future challenge
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        Then I should see the title "Edit Challenge: Temp Challenge 1"
        And I should see the Challenge Start Date as "2024-10-02"
        And I should see the Challenge End Date as "2024-10-31"

    Scenario: Unauthorized access redirects
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as a trainee
        When I visit the edit page for challenge "Temp Challenge 1"
        And I should be at the home page and see "You are not an instructor."