Feature: Login
  As a user,
  I want to login to my account
  To access my data
  Background:
    Given A user is registered with the email "Admin@gmail.com" and password "Admin@123"

  Scenario: Login using correct email and password
    Given I am not currently Logged in
    And I am on the Login page
    When I enter Admin@gmail.com as email
    And I enter Admin@123 as password
    And I click on submit
    Then I should see 'You have successfully signed in'

  Scenario: Login using incorrect email or password
    Given I am not currently Logged in
    And I am on the Login page
    When I enter Admin@gmail.com as email
    And I enter abcd@123 as password
    And I click on submit
    Then I should see 'Incorrect email or password. Please try again.'

  Scenario: Login using empty email
    Given I am not currently Logged in
    And I am on the Login page
    When I enter '' as email
    And I enter abcd@123 as password
    And I click on submit
    Then I should see 'Incorrect email or password. Please try again.'

  Scenario: Login using empty password
    Given I am not currently Logged in
    And I am on the Login page
    When I enter Admin@gmail.com as email
    And I enter '' as password
    And I click on submit
    Then I should see 'Incorrect email or password. Please try again.'

  Scenario: Login as trainee
    Given I am not currently Logged in
    And A trainee is registered with the email "trainee@gmail.com" and password "trainee@123"
    And I am on the Login page
    When I enter 'trainee@gmail.com' as email
    And I enter 'trainee@123' as password
    And I click on submit
    Then I should see 'Sign Out'
