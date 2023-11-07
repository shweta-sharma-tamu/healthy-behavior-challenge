Feature: Instructor ListChallenges
  As a trainee,
  I want to see a list of challenges with name, start, and end date I was a part of. 
  To keep track of the challenges.


  Scenario: Trainee can see Ongoing challenges
    Given I am a trainee with following challenges:
      | name       | startDate   | endDate     | tasks                   |
      | Challenge1 | 2023-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
      | Challenge2 | 2023-09-11  | 2024-10-22  | Task 1, Task 2, Task 3  |
      | Challenge3 | 2023-09-15  | 2023-10-06  | Task 1, Task 2, Task 3  |
    Given I am Logged in with username 'testTrainee@gmail.com' and password 'abcdef'
    And I visit 'My Challenges'
    Then I should see 'Ongoing Challenges'
    And I should see 'Challenge1' and 'Challenge2'
    And 'Challenge2' should be before 'Challenge1'

  Scenario: Trainee can see Past challenges
    Given I am a trainee with following challenges:
      | name       | startDate   | endDate     | tasks                   |
      | Challenge1 | 2000-10-02  | 2020-10-20  | Task 1, Task 2, Task 3  |
      | Challenge4 | 2000-10-02  | 2021-10-20  | Task 1, Task 2, Task 3  |
      | Challenge2 | 2023-09-11  | 2026-10-22  | Task 1, Task 2, Task 3  |
      | Challenge3 | 2090-09-15  | 2090-10-06  | Task 1, Task 2, Task 3  |
    Given I am Logged in with username 'testTrainee@gmail.com' and password 'abcdef'
    And I visit 'My Challenges'
    Then I should see 'Past Challenges'
    And I should see 'Challenge1' and 'Challenge4'
    And 'Challenge1' should be before 'Challenge4'