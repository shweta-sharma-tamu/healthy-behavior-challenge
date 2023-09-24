Feature: Forgot Password
  As a user
  I want to reset my password
  So that I can regain access to my account

  Background:
    Given there is a registered user with the email "user@example.com"

  Scenario: Request a password reset email
    Given I am on the login page
    When I click on the "Forgot Password" link
    And I fill in my email address with "user@example.com"
    And I click the "Reset Password" button
    Then I should see a message "If an account with email was found, we have a sent a link to reset your password"

  Scenario: Request a password reset email for a non-existing email
    Given I am on the login page
    When I click on the "Forgot Password" link
    And I fill in my email address with "nonexistent@example.com"
    And I click the "Reset Password" button
    Then I should see an error message "If an account with email was found, we have a sent a link to reset your password"

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

