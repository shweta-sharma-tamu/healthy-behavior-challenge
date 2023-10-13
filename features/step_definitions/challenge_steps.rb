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
    user = User.create!(email: 'trainee@example.com', password: '123456', user_type: "Trainee")

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

    Challenge.create!(name: challenge, startDate: '2023-10-15', endDate: '2023-10-30', instructor: instructor, tasks_attributes: {
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
    click_button "Create the challenge"
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