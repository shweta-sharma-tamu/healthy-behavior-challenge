Feature: Login
  As a user,
  I want to login to my account
  To access my data


  Scenario: Login using correct username and password
    Given I am on the Login page
    When I enter admin@gmail.com as username
    And I enter Admin@123 as password
    Then I should see 'Successfully logged in'
