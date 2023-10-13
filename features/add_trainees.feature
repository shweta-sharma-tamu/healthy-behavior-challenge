Feature: Add Trainees

  Scenario: Add Trainees to a Challenge
    Given I am an instructor trying to add trainees to a challenge
    And I am on the Add Trainees page for "Sample Challenge"
    And I should see all trainees who are not in the challenge
    Then I select a trainee and add it to "Sample Challenge"
    And I click on "Add Trainees"
    Then I should see "Trainees were successfully added to the challenge."
