Feature: Instructor SignUp

  Scenario: Instructor can signup successfully with valid information
    Given I am on instructor signup page 
    When I fill in email with instructorsignup3@gmail.com
    And I fill in password with signup111
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Welcome, Peter!' message

  Scenario: Instructor cannot signup with empty email
    Given I am on instructor signup page 
    When I fill in email with '' 
    And I fill in password with signup111
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter 
    And I fill in last_name with John
    And I click on signup
    Then I should see 'Incorrect email or password. Please try again.' message

  Scenario: Instructor cannot signup with empty password
    Given I am on instructor signup page 
    When I fill in email with instructorsignup4@gmail.com 
    And I fill in password with ''
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter 
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Incorrect email or password. Please try again.' message

Scenario: Instructor cannot signup with invalid email
    Given I am on instructor signup page 
    When I fill in email with instructorsignup 
    And I fill in password with signup111
    And I fill in confirm_password with signup111
    And I fill in first_name with Peter 
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Please enter valid email and try again.' message    
  
Scenario: Instructor cannot signup with password mismatch
    Given I am on instructor signup page 
    When I fill in email with instructorsignup 
    And I fill in password with signup111
    And I fill in confirm_password with signup123
    And I fill in first_name with Peter 
    And I fill in last_name with John  
    And I click on signup
    Then I should see 'Password Mismatch.' message
    