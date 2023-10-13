Feature: Instructor ListChallenges
  As an instructor,
  I want to see a list of current ongoing challenges with name, start, and end date. 
  To keep track of the challenges.


  Scenario: Instructor can see Ongoing challenges
    Given I am an instructor with following challenges:
      | name       | startDate   | endDate     | tasks                   |
      | Challenge1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2, Task 3  |
      | Challenge2 | 2023-09-11  | 2023-10-22  | Task 1, Task 2, Task 3  |
      | Challenge3 | 2023-09-15  | 2023-10-06  | Task 1, Task 2, Task 3  |
    Given I am Logged in with username 'testInstructor@gmail.com' and password 'abcdef'
    Then I should see 'Ongoing Challenges'
    And I should see 'Challenge1' and 'Challenge2'
    And I should not see 'Challenge3'
    And 'Challenge2' should be before 'Challenge1'


