Feature: Trainee Signup
    As a trainee
    I want to sign up
    To access the website

    Scenario: Signs up with valid information
        Given I am on the signup page
        When I fill in "Full Name" with "new user"
        And I fill in "Email" with "user@example.com"
        And I fill in "Password" with "password123"
        And I fill in "Password confirmation" with "password123"
        And I fill in "Height" with "175"
        And I fill in "Weight" with "70"
        And I click the "Sign Up" button
        Then I should be on the homepage
        And I should see "Signup successful!"

    Scenario: Signs up with with empty name
        Given I am on the signup page
        When I fill in "Full Name" with ""
        And I fill in "Email" with "user@example.com"
        And I fill in "Password" with "password123"
        And I fill in "Password confirmation" with "password123"
        And I fill in "Height" with "175"
        And I fill in "Weight" with "70"
        And I click the "Sign Up" button
        Then I should stay on the signup page
        And I should see an error message indicating that name field is empty
    
    Scenario: Signs up with a duplicate email
        Given A trainee with the email "user@example.com" already exists
        When I fill in "Full Name" with "new user"
        And I fill in "Email" with "user@example.com"
        And I fill in "Password" with "password123"
        And I fill in "Password confirmation" with "password123"
        And I fill in "Height" with "175"
        And I fill in "Weight" with "70"
        And I click the "Sign Up" button
        Then I should stay on the signup page
        And I should see an error message indicating that the email is already taken

    Scenario: Signs up with a weak password
        Given I am on the signup page
        When I fill in "Full Name" with "new user"
        And I fill in "Email" with "user@example.com"
        And I fill in "Password" with "weak"
        And I fill in "Password confirmation" with "weak"
        And I fill in "Height" with "175"
        And I fill in "Weight" with "70"
        And I click the "Sign Up" button
        Then I should stay on the signup page
        And I should see an error message indicating that the password is too short

    Scenario: Signs up with password and confirmation mismatch
        Given I am on the signup page
        When I fill in "Full Name" with "new user"
        And I fill in "Email" with "user@example.com"
        And I fill in "Password" with "password123"
        And I fill in "Password confirmation" with "different_password"
        And I fill in "Height" with "175"
        And I fill in "Weight" with "70"
        And I click the "Sign Up" button
        Then I should stay on the signup page
        And I should see an error message indicating that the password confirmation does not match the password

    Scenario: Signs up with invalid email format
        Given I am on the signup page
        When I fill in "Full Name" with "new user"
        And I fill in "Email" with "invalid_email"
        And I fill in "Password" with "password123"
        And I fill in "Password confirmation" with "password123"
        And I fill in "Height" with "175"
        And I fill in "Weight" with "70"
        And I click the "Sign Up" button
        Then I should stay on the signup page
        And I should see an error message indicating that the email format is invalid

    Scenario: Signs up with invalid height value
        Given I am on the signup page
        When I fill in "Full Name" with "new user"
        And I fill in "Email" with "user@example.com"
        And I fill in "Password" with "newpassword123"
        And I fill in "Password confirmation" with "newpassword123"
        And I fill in "Height" with "-10"
        And I fill in "Weight" with "80"
        And I click the "Sign Up" button
        Then I should stay on the signup page
        And I should see error message indicating that height must be greater than 0

    Scenario: Signs up with invalid weight value
        Given I am on the signup page
        When I fill in "Full Name" with "new user"
        And I fill in "Email" with "user@example.com"
        And I fill in "Password" with "newpassword123"
        And I fill in "Password confirmation" with "newpassword123"
        And I fill in "Height" with "-10"
        And I fill in "Weight" with "80"
        And I click the "Sign Up" button
        Then I should stay on the signup page
        And I should see error message indicating that weight must be greater than 0