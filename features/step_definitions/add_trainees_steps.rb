Given("I am an instructor trying to add trainees to a challenge") do
    user = User.create(email: 'instructor2@example.com', password: 'abcdef', user_type: "Instructor")
    instructor = Instructor.create(user_id: user.id, first_name: 'John', last_name: 'Doe')

    user_2 = User.create(email: 'trainee1@example.com', password: 'abcdefg', user_type: "Trainee")

    user_3 = User.create(email: 'trainee2@example.com', password: 'abcdefgh', user_type: "Trainee")

    trainee_1 = Trainee.create(full_name:'Trainee1 Name', height:1, weight:1, user_id:2)
    trainee_2 = Trainee.create(full_name:'Trainee2 Name', height:2, weight:2, user_id:3)
  
    # Use Capybara to log in as the user
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    challenge_1 = Challenge.create(name: 'Sample Challenge', startDate: '2023-10-15', endDate: '2023-10-30', instructor: instructor, tasks_attributes: {
        '0' => { taskName: 'Task 1' },
        '1' => { taskName: 'Task 1' }  # Use a different name for the second task
      })
  end

  When("I am on the Add Trainees page for {string}") do |challenge_name|
    challenge = Challenge.find_by(name: challenge_name)
    visit add_trainees_challenge_path(challenge.id)
  end

  When("I select Trainee {int}") do |trainee_id|
    check "trainee_#{trainee_id}" # Assuming you have checkboxes with IDs like "trainee_1", "trainee_2", etc.
  end
  
  When("I press Add Trainees") do
    click_button "Add Trainees" # Make sure this matches your actual button text
  end
  
  Then("I should see {string}") do |message|
    expect(page).to have_content(message)
  end
