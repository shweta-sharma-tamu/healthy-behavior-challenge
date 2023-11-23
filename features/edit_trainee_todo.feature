Feature: Edit Trainee To-Do list 
    As an Instructor
    I want to edit a trainee's to-do list
    So that I can customize it as needed

    Scenario: View edit to-do list page
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for "tempTrainee1" and "Temp Challenge 1"
        Then I should see the title "Current Todo List: tempTrainee1"

    Scenario: View edit to-do list page for Future challenge
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as an Instructor
        When I visit the edit page for "tempTrainee1" and "Temp Challenge 1"
        Then I should see the title "Current Todo List: tempTrainee1"
        And I should see the Start Date as "2024-10-02"

    Scenario: Unauthorized access redirects
        Given there is a challenge "Temp Challenge 1" with a trainee "tempTrainee1" and following details:
        | name             | startDate   | endDate     | tasks                   |
        | Temp Challenge 1 | 2024-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
        And I am logged in as a trainee
        When I visit the edit page for "tempTrainee1" and "Temp Challenge 1"
        And I should be at the home page and see "You are not an instructor."