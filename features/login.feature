Feature: Login
  As a user,
  I want to login to my account
  To access my data

  Scenario: Login using correct email and password
    Given I am on the Login page
    When I enter admin@gmail.com as email
    And I enter Admin@123 as password
    And I click on submit
    Then I should see 'Successfully logged in'

  Scenario: Login using incorrect email and password
    Given I am on the Login page
    When I enter admin@gmail.com as email
    And I enter abcd@123 as password
    And I click on submit
    Then I should see 'Incorrect email or password. Please try again.'

  Scenario: Login using empty email
    Given I am on the Login page
    When I enter '' as email
    And I enter abcd@123 as password
    And I click on submit
    Then I should see 'Enter a valid email address.'

  Scenario: Login using empty password
    Given I am on the Login page
    When I enter admin@gmail.com as email
    And I enter '' as password
    And I click on submit
    Then I should see 'Enter a valid password.'
