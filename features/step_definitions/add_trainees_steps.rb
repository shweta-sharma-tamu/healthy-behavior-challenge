Given("I am an instructor trying to add trainees to a challenge") do
    user = User.create(email: 'instructor2@example.com', password: 'abcdef', user_type: "Instructor")
    instructor = Instructor.create(user_id: user.id, first_name: 'John', last_name: 'Doe')

    user_2 = User.create(email: 'trainee1@example.com', password: 'abcdefg', user_type: "Trainee")

    user_3 = User.create(email: 'trainee2@example.com', password: 'abcdefgh', user_type: "Trainee")
    user_4 = User.create(email: 'trainee3@example.com', password: 'abcdefgh', user_type: "Trainee")

    trainee_1 = Trainee.create(full_name:'Trainee1 Name', height:1, weight:1, user_id:2)
    trainee_2 = Trainee.create(full_name:'Trainee2 Name', height:2, weight:2, user_id:3)
    trainee_3 = Trainee.create(full_name:'Trainee3 Name', height:2, weight:2, user_id:4)
  
    # Use Capybara to log in as the user
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    challenge_1 = Challenge.create(name: 'Sample Challenge', startDate: '2023-10-15', endDate: '2023-10-30', instructor: instructor, tasks_attributes: {
        '0' => { taskName: 'Task 1' },
        '1' => { taskName: 'Task 1' }  # Use a different name for the second task
      })

    challengeTrainee_1 = ChallengeTrainee.create(challenge_id: challenge_1.id , trainee_id: trainee_1.id)

  end

  When("I am on the Add Trainees page for {string}") do |challenge_name|
    challenge = Challenge.find_by(name: challenge_name)
    visit add_trainees_challenge_path(challenge.id)
  end

  And("I should see all trainees who are not in the challenge") do
    expect(page).to have_content('Trainee2 Name') 
    expect(page).to have_content('Trainee3 Name')
  end
  
  Then("I select a trainee and add it to {string}")  do |challenge_name|

    # Extract the CSRF token from the page's meta tags
    #csrf_token = find("meta[name=csrf-token]")[:content]
    # challenge = Challenge.find_by(name: challenge_name)
    # trainee_2 = Trainee.find_by(full_name:'Trainee2 Name')
    # page.driver.post update_trainees_challenge_path(challenge.id), {trainee_ids: [trainee_2.id], headers: { "HTTP_X_CSRF_TOKEN" => csrf_token }  }

    challenge = Challenge.find_by(name: challenge_name)
    trainee_2 = Trainee.find_by(full_name:'Trainee2 Name')

    post update_trainees_challenge_path(challenge.id, {trainee_ids: [trainee_2.id]}) # Assuming this is a POST request
    fill_in "traineeSearch", with: trainee_2.full_name # Assuming this is the input field for trainee_ids
    

    # Optionally, you can also wait for the form to be submitted (if using AJAX)
   #expect(page).to have_text("Trainees were successfully added to the challenge.")

  end

  And("I click on {string}") do |button_text|
    click_on button_text
  end

