Feature: Instructor SignUp

  Scenario: Instructor can signup successfully with valid information
    Given I am on instructor signup page 
    When I fill in email with "instructorsignup@gmail.com"
    And I fill in first_name with "instructor_first_name" 
    And I fill in last_name with "instructor_last_name"  
    And I fill in password with "password" 
    And I fill in referral_code with "referal_code123"  
    And I click on signup button
    Then I should see "Welcome!, test_first_name" message

  Scenario: Instructor cannot signup with empty email
    Given I am on instructor signup page 
    When I fill in email with ""
    And I fill in first_name with "instructor_first_name" 
    And I fill in last_name with "instructor_last_name"  
    And I fill in password with "password"
    And I fill in confirm_password with "confirm_password"
    And I fill in referral_code with "referal_code123"  
    And I click on signup button
    Then I should see error "Email cannot be empty" message

  Scenario: Instructor cannot signup with empty password
    Given I am on instructor signup page 
    When I fill in "email" with "test_email"
    And I fill in "first name" with "test_first_name"
    And I fill in "last name" with "test_last_name"
    And I fill in "password" with ""
    And I fill in confirm_password with ""
    And I fill in "referal_code" with "test_referal_code"
    And I click on "Sign Up" button
    Then I should display "Password cannot be empty" message
  
    