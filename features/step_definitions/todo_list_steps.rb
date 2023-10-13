# features/step_definitions/todo_list_steps.rb

  Given('I am logged in') do
    @user2 = User.create!(email: 'instructor@example.com', password: 'abcdef',user_type: "Instructor")
    @instructor = Instructor.create(user_id: @user2.id, first_name: "instructor1", last_name: "instructor_last_name")

    @user = User.create!(email: 'traineetest@example.com', password: 'asdf',user_type: "trainee")
    @trainee = Trainee.create(full_name: 'trainee1', height: 165, weight: 85, user_id: @user.id)

    @challenge1 = Challenge.create(name: 'challenge1', startDate: Date.today, endDate: Date.today, instructor_id: @instructor.id)
    @challengetrainee = ChallengeTrainee.create(trainee_id: @trainee.id, challenge_id: @challenge1.id)
    @task1 = Task.create(taskName: "exercise")
    @task2 = Task.create(taskName: "steps")
    @todolisttask = TodolistTask.create(task_id: @task1.id, status: "not_completed", trainee_id: @trainee.id, challenge_id: @challenge1.id, date: Date.today)
    @todolisttask = TodolistTask.create(task_id: @task2.id, status: "not_completed", trainee_id: @trainee.id, challenge_id: @challenge1.id, date: Date.today)
    
    puts @user.email
    visit login_path
    expect(page).to have_content('User Sign in')
    fill_in 'email', with: 'traineetest@example.com'
    fill_in 'password', with: 'asdf'
    click_button 'Sign In'
    expect(page).to have_content("Welcome")
    puts @user.id
  end
  
  When('I click on {string}') do |string|
    click_link(string)
  end
  
  Then('I should be on the todo list page') do
    expect(page).to have_current_path(todo_list_path, ignore_query: true)
  end
  
  When('I check the {string} checkbox for a task') do |string|
    task_id = Task.find_by(taskName: string).id
    check("tasks[#{task_id}][completed]")
  end
  
  When('I click button {string}') do |string|
    click_button(string)
  end
  
  Then('I should be able to see a notice {string}') do |string|
    expect(page).to have_content(string)
  end

  Then('I should be able to see {string}') do |content|
    expect(page).to have_content(content)
  end
  
  And('I should see {string} in a strikethrough') do |content|
    expect(page).to have_css('s', text: content)
  end
  
