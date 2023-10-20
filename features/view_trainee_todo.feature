Feature: Instructor ViewTraineeTodo
    As an instructor
    I want to see the todo list for a trainee for  a particular challenge and day
    To enable me to track progress and make changes


  Scenario: Instructor can see Trainee Todolist
    Given I am an instructor with a trainee 'TestTrainee' and following challenges:
      | name       | startDate   | endDate     | tasks                   |
      | Challenge1 | 2023-10-02  | 2023-10-31  | Task 1, Task 2, Task 3  |
      | Challenge2 | 2023-09-11  | 2023-10-22  | Task 1, Task 2, Task 3  |
      | Challenge3 | 2023-09-15  | 2023-10-06  | Task 1, Task 2, Task 3  |
    And I am Logged in with username 'testInstructor@gmail.com' and password 'abcdef'
    And I click on challenge 'Challenge1'
    And I click on 'Show Participants'
    And I click on trainee 'TestTrainee'
    Then I should see 'TestTrainee'
    And I should see 'Challenge1' 
    And I should see '2023-09-15'

  Scenario: Instructor can see Trainee Todolist for current day for Ongoing challenge
    Given I am an instructor with a trainee 'TestTrainee' and an Ongoing Challenge 'Challenge1'
    And I am Logged in with username 'testInstructor@gmail.com' and password 'abcdef'
    And I click on challenge 'Challenge1'
    And I click on 'Show Participants'
    And I click on trainee 'TestTrainee'
    Then I should see 'TestTrainee'
    And I should see 'Challenge1' 
    And I should see Current Date

  Scenario: Instructor can see Trainee Todolist for 'start date' for Future challenge
    Given I am an instructor with a trainee 'TestTrainee' and a Future Challenge 'Challenge1' with start date of tomorrow
    And I am Logged in with username 'testInstructor@gmail.com' and password 'abcdef'
    And I click on challenge 'Challenge1'
    And I click on 'Show Participants'
    And I click on trainee 'TestTrainee'
    Then I should see 'TestTrainee'
    And I should see 'Challenge1' 
    And I should see tomorrows date