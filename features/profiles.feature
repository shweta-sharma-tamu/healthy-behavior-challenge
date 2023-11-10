Feature: Manage Instructor Profile

  Background:
    Given I am logged in as an instructor

  Scenario: View My Profile Button
    Then I should see the "My Profile" profile button in the top right corner of the navigation bar

  Scenario: View Instructor Profile
    When I visit the instructor profile page
    Then I should see my email, first name, and last name
    And I should be able to see 'Edit Profile' button

  Scenario: Edit Instructor Profile
    When I visit the instructor profile page
    When I click on the displayed "Edit Profile" button
    And I fill in the new first name and last name
    And I click on the displayed "Update Profile" button
    Then I should see a success message
    And I should see my updated first name and last name on the profile page
