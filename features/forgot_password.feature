Feature: Forgot Password
  As a user
  I want to reset my password
  So that I can regain access to my account
    

  Scenario: Request a password reset email
    Given there is a registered user with the email "userexists3@example.com"
    And I am on the login page
    When I click on the "Forgot Password" link
    And I fill in my email address with "userexists3@example.com"
    And I click the "Reset Password" button
    Then I should see a message "If an account with email was found, we have sent a link to reset your password."

  Scenario: Request a password reset email for a non-existing email
    Given I am on the login page
    When I click on the "Forgot Password" link
    And I fill in my email address with "nonexistent@example.com"
    And I click the "Reset Password" button
    Then I should see an error message "If an account with email was found, we have sent a link to reset your password."

  Scenario: Request a password reset email with an invalid email format
    Given I am on the login page
    When I click on the "Forgot Password" link
    And I fill in my email address with "invalid-email"
    And I click the "Reset Password" button
    Then I should see an error message "Invalid email format. Please enter a valid email address."

  Scenario: Request a password reset email with an empty email field
    Given I am on the login page
    When I click on the "Forgot Password" link
    And I click the "Reset Password" button
    Then I should see an error message "Email can't be blank."
  
  Scenario: Editing a Password Reset
    Given a valid password reset token
    When I visit the password reset edit page with the token
    Then I should see the password reset form
    And I should see a field labeled "Password"
    And I should see a field labeled "Password confirmation"
    And I should see a button labeled "Reset Password"

  Scenario: Expired Token
    Given an expired password reset token
    When I visit the password reset edit page with the token
    Then I should be redirected to the root page with an error message

  Scenario: Updating the Password
    Given a valid password reset token
    When I visit the password reset edit page with the token
    And I fill in password with "new_password"
    And I fill in password_confirmation with "new_password"
    And I click the "Reset Password" button
    Then I should be redirected to the root page with a success message

  Scenario: Invalid Password Confirmation
    Given a valid password reset token
    When I visit the password reset edit page with the token
    And I fill in password with "new_password"
    And I fill in password_confirmation with "new_password12"
    And I click the "Reset Password" button
    Then I should see an error message on the edit page

