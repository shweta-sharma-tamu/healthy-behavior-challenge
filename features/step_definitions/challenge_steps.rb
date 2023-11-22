# features/step_definitions/challenge_steps.rb
  Given("I am an instructor") do
    user = User.create!(email: 'instructor@example.com', password: 'abcdef', user_type: "Instructor")
    instructor = Instructor.create(user: user, first_name: 'John', last_name: 'Doe')
  
    # Use Capybara to log in as the user
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    Challenge.create!(name: 'ex chall', startDate: '2023-10-15', endDate: '2023-10-30', instructor: instructor, tasks_attributes: {
        '0' => { taskName: 'Task 1' },
        '1' => { taskName: 'Task 1' }  # Use a different name for the second task
      })
  end
  
  Given("I am not an instructor") do
    user = User.create!(email: 'trainee1@example.com', password: '123456', user_type: "Trainee1")
    trainee = Trainee.create(full_name: 'trainee1', height: 165, weight: 85, user_id: user.id)

    # Use Capybara to log in as the user
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end
  

  Given ("I am an instructor and There exists a challenge {string}") do |challenge|
    user = User.create!(email: 'instructor@example.com', password: 'abcdef', user_type: "Instructor")
    instructor = Instructor.create(user: user, first_name: 'John', last_name: 'Doe')
  
    # Use Capybara to log in as the user
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    @challenge = Challenge.create!(name: challenge, startDate: '2023-10-15', endDate: '2023-10-30', instructor: instructor, tasks_attributes: {
        '0' => { taskName: 'Task 1' },
        '1' => { taskName: 'Task 1' }  # Use a different name for the second task
      })
  end
  
  Given("I am on the new challenge page") do
    visit new_challenge_path
  end
  

  When("I fill {string} with {string}") do |field, value|
    fill_in field, with: value
  end
  
  When("I press Create Challenge") do 
    click_button "Create Challenge"
  end

  When('I visit the new challenge page') do
    visit new_challenge_path
  end
  
  # Implement additional step definitions as needed
  And("I fill in the task name field with {string}") do |task_name|
    task_field = find('input[type="text"][name^="challenge[tasks_attributes]"]')
    task_field.set(task_name)
  end

  When("I click on the challenge {string}") do |string|
    challenge = Challenge.find_by(name: string)
    visit challenge_path(challenge)
  end

  Then('I should see the heading {string}') do |string|
    expect(page).to have_content("#{string}")
  end

  Then("I should see the {string}") do |string|
    expect(page).to have_content("#{string}")
  end  

  Then("I should see the {string} button") do |label|
    button = find_button(label)
    expect(button).to be_present
  end 
  And("there are trainees in the challenge {string}") do |challenge|
    user1 = User.create!(email: 'trainee22@example.com', password: 'abcdef', user_type: "Trainee")
    user2 = User.create!(email: 'trainee2@example.com', password: 'abcdef', user_type: "Trainee")
    user3 = User.create!(email: 'trainee3@example.com', password: 'abcdef', user_type: "Trainee")
    @trainee1 = Trainee.create!(full_name: "blah 1",user: user1,height:120,weight:120)
    @trainee2 = Trainee.create!(full_name: "blah 2",user: user2,height:120,weight:120)
    @trainee3 = Trainee.create!(full_name: "blah 3",user: user3,height:120,weight:120)
    Challenge.find_by(name: challenge).trainees << [@trainee1,@trainee2,@trainee3]
  end

  When('I visit the list trainees page') do
    visit challenge_list_trainees_path(challenge_id: @challenge.id)
  end

  Then('I should see list of trainees of that challenge') do
    expect(page).to have_content(@trainee1.full_name)
  end

  And('a trainee is present in a challenge {string}') do |challenge|
    user1 = User.create!(email: 'trainee2132@example.com', password: 'abcdef', user_type: "Trainee")
    @trainee1 = Trainee.create!(full_name: "blah 1",user: user1,height:120,weight:120)
    @challenge1=Challenge.find_by(name: challenge)
    @challenge1.trainees << @trainee1
    @task=Task.create!(taskName:"drink water")
    TodolistTask.create!(trainee_id: @trainee1.id, task_id: @task.id, challenge_id: @challenge1.id, date: Date.today+1,status:"not_completed")

  end
  
  When('I visit the task progress page') do
    visit graph_challenge_path(trainee_id: @trainee1, id: @challenge1.id)
  end
  
  Then('I should see the task progress chart') do
    expect(page).to have_content('Progress Overview: blah 1')
  end
  