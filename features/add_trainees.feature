Feature: Add Trainees

  Scenario: Add Trainees to a Challenge
    Given I am an instructor trying to add trainees to a challenge
    And I am on the Add Trainees page for "Sample Challenge"
    And I select Trainee 1
    And I select Trainee 2
    And I press Add Trainees
    Then I should see "Trainees were successfully added to the challenge."
