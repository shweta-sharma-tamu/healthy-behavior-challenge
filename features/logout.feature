Feature: User Logout
  As a logged-in user
  I want to be able to sign out
  So that I can end my session and protect my account

  Scenario: User logs out successfully
    Given I am a logged-in user
    When I should see a "Sign Out" button
    Then I click the "Sign Out" button
    Then I should be redirected to the home page
    And I should see a message "You have been signed out"
    And I should not see a "Sign Out" button

  Scenario: User tries to log out when not logged in
    Given I am not logged in
    When I visit the signout page
    Then I should be redirected to the home page
