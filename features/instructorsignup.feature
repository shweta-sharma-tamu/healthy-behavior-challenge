Feature: Instructor SignUp

  As an Instructor,
  I want to send a referral mail with a unique link
  So that new specified user can access the signup page

  Background:
    Given I received email with referral link

  Scenario: Instructor can signup successfully with valid information
    Given I click the sent referral link and redirected to signup page 
    When I fill in email with instructorsignup3@gmail.com
    And I fill in password with signup111
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Welcome, Peter!' message

  Scenario: Instructor cannot signup with empty email
    Given I click the sent referral link and redirected to signup page 
    When I fill in email with '' 
    And I fill in password with signup111
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter 
    And I fill in last_name with John
    And I click on signup
    Then I should see 'Sign up' page

  Scenario: Instructor cannot signup with empty password
    Given I click the sent referral link and redirected to signup page 
    When I fill in email with instructorsignup4@gmail.com 
    And I fill in password with ''
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter 
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Sign up' page

Scenario: Instructor cannot signup with invalid email
    Given I click the sent referral link and redirected to signup page 
    When I fill in email with instructorsignup 
    And I fill in password with signup111
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter 
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Sign up' page    
  
Scenario: Instructor cannot signup with password mismatch
    Given I click the sent referral link and redirected to signup page 
    When I fill in email with instructorsignup 
    And I fill in password with signup111
    And I fill in confirm_password with signup123
    And I fill in first_name with Peter 
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Sign up' page
    