Feature: Edit Challenge Genric To-Do list 
    As an Instructor
    I want to edit the genric todo list of a challenge
    So that I can update it as needed

    Scenario: View edit to-do list page
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        Then I should see the title "Current todo list for Temp Challenge 1"

    Scenario: View edit to-do list page for Future challenge
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for challenge "Temp Challenge 1"
        Then I should see the title "Current todo list for Temp Challenge 1"
        And I should see the Start Date as "October 02, 2024"
        And I should see the End Date as "October 31, 2024"

    Scenario: Unauthorized access redirects
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as a trainee
        When I visit the edit page for challenge "Temp Challenge 1"
        And I should be at the home page and see "You are not an instructor."