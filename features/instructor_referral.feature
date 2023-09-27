Feature: Instructor Referral
  As an Instructor,
  I want to send a referral mail with a unique link
  So that new specified user can access the signup page

  Background:
    Given there is a instructor registered user with the email "instructor@example.com"

  Scenario: Sending a referral email with a unique link
    Given I am logged in as an instructor with email "instructor@example.com" and password "password"
    When I navigate to the referral page
    And I fill in the recipient's email with "newuser@example.com"
    And I click the "Send Referral Email" button
    Then a unique referral link should be generated and sent to "newuser@example.com"
    And I should see a success message

  Scenario: New user accessing the signup page through the referral link
    Given I receive a referral email with a unique link
    When I click the referral link
    Then I should be redirected to the signup page
    And the referral code should be associated with my account