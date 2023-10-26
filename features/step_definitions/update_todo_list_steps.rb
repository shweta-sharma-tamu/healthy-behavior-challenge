Given('there is a challenge {string} with the trainee {string} with the following details:') do |challenge_name, trainee_name, table|
    user = User.create!(email: 'testInstructor@gmail.com', password: 'abcdef', user_type: "Instructor")
    trainee_user = User.create!(email: 'tempTrainee1@gmail.com', password: 'abcdef', user_type: "Trainee")

    instructor = Instructor.create!(user: user, first_name: 'John', last_name: 'Doe')
    trainee = Trainee.create!(user: trainee_user, full_name: trainee_name, height: 150, weight: 55)

    table.hashes.each do |challenge|
        challenge_create = Challenge.create!(name: challenge['name'], startDate: challenge['startDate'], endDate: challenge['endDate'], instructor: instructor, tasks_attributes: {
            '0' => { taskName: 'Task 1' },
            '1' => { taskName: 'Task 2' }  
          })

        challenge_create.trainees << Trainee.where(id: trainee.id)
        challenge_trainee = ChallengeTrainee.new(challenge: @challenge, trainee: trainee)
        challenge_trainee.save

        tasks = challenge_create.tasks
        tasks.each do |task|
            (challenge_create.startDate..challenge_create.endDate).each do |date|
              tasktodo = TodolistTask.new(
                task: task,
                trainee: trainee,      
                challenge: @challenge, 
                date: date            
              )
                tasktodo.save   
            end
        end           
    end
end
  
Given('today is {string}') do |current_date|
    # Set the current date for testing purposes
    # This can be used to simulate the current date in your scenarios
end

When('I update the task list with the following tasks:') do |table|
    table.hashes.each_with_index do |row, index|
        within("#update-todo-list-form") do
            all('input[name^="todo_list[task_list]"]').each_with_index do |task_field, index|
                task_field.fill_in(with: table.hashes[index]['tasks'])
            end
        end
    end

    click_button 'Update Challenge'
end
  
Then('I should be redirected to the edit page for {string}') do |challenge_name|
    challenge = Challenge.find_by(name: challenge_name)

    expect(current_path).to eq(edit_todo_list_challenge_path(challenge))
end

Then('I should be redirected to the details page for {string}') do |challenge_name|
    challenge = Challenge.find_by(name: challenge_name)

    expect(current_path).to eq(challenge_path(challenge))
end
  
Then('I should see a flash notice with the message {string}') do |message|
    expect(page).to have_content("#{message}")
end
  