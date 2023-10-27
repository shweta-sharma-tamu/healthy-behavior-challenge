Feature: Instructor ListChallenges
  As an instructor,
  I want to see a list of challenges with name, start, and end date. 
  To keep track of the challenges.


  Scenario: Instructor can see Ongoing challenges
    Given I am an instructor with following challenges:
      | name       | startDate   | endDate     | tasks                   |
      | Challenge1 | 2023-10-02  | 2024-10-31  | Task 1, Task 2, Task 3  |
      | Challenge2 | 2023-09-11  | 2024-10-22  | Task 1, Task 2, Task 3  |
      | Challenge3 | 2023-09-15  | 2023-10-06  | Task 1, Task 2, Task 3  |
    Given I am Logged in with username 'testInstructor@gmail.com' and password 'abcdef'
    Then I should see 'Ongoing Challenges'
    And I should see 'Challenge1' and 'Challenge2'
    And I should not see 'Challenge3'
    And 'Challenge2' should be before 'Challenge1'

  Scenario: Instructor can see Past challenges
    Given I am an instructor with following challenges:
      | name       | startDate   | endDate     | tasks                   |
      | Challenge1 | 2000-10-02  | 2020-10-20  | Task 1, Task 2, Task 3  |
      | Challenge4 | 2000-10-02  | 2021-10-20  | Task 1, Task 2, Task 3  |
      | Challenge2 | 2023-09-11  | 2026-10-22  | Task 1, Task 2, Task 3  |
      | Challenge3 | 2090-09-15  | 2090-10-06  | Task 1, Task 2, Task 3  |
    Given I am Logged in with username 'testInstructor@gmail.com' and password 'abcdef'
    And I am in Past Challenges Page
    Then I should see 'Past Challenges'
    And I should see 'Challenge1' and 'Challenge4'
    And I should not see 'Challenge2'
    And 'Challenge1' should be before 'Challenge4'

  Scenario: Instructor can see upcoming challenges
    Given I am an instructor with following challenges:
      | name       | startDate   | endDate     | tasks                   |
      | Challenge1 | 2000-10-02  | 2020-10-20  | Task 1, Task 2, Task 3  |
      | Challenge4 | 2000-10-02  | 2021-10-20  | Task 1, Task 2, Task 3  |
      | Challenge2 | 2029-09-11  | 2029-10-22  | Task 1, Task 2, Task 3  |
      | Challenge3 | 2090-09-15  | 2090-10-06  | Task 1, Task 2, Task 3  |
    Given I am Logged in with username 'testInstructor@gmail.com' and password 'abcdef'
    And I am in Upcoming Challenges Page
    Then I should see 'Upcoming Challenges'
    And I should see 'Challenge2' and 'Challenge3'
    And I should not see 'Challenge1'
    And 'Challenge2' should be before 'Challenge3'

