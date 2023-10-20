

Given('I am an instructor with a trainee {string} and following challenges:') do |string, table|
    user = User.create!(email: 'testInstructor@gmail.com', password: 'abcdef', user_type: "Instructor")
    instructor = Instructor.create(user: user, first_name: 'John', last_name: 'Doe')
    user_trainee = User.create!(email: 'testTrainee@gmail.com', password: 'abcdef', user_type: "Trainee")
    trainee = Trainee.create(user: user_type, first_name: string, last_name: 'Doe') 
    table.hashes.each do |challenge|
        Challenge.create!(name: challenge['name'], startDate: challenge['startDate'], endDate: challenge['endDate'], instructor: instructor, tasks_attributes: {
            '0' => { taskName: 'Task 1' },
            '1' => { taskName: 'Task 1' }  # Use a different name for the second task
          })
     end
    end
    
  Given('I am an instructor with a trainee {string} and an Ongoing Challenge {string}') do |string, string2|
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  Given('I am an instructor with a trainee {string} and a Future Challenge {string} with start date of tomorrow') do |string, string2|
    pending # Write code here that turns the phrase above into concrete actions
  end
  

Given('I click on challenge {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

Given('I click on trainee {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

Given('The trainee is registered for an Ongoing Challenge {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see Current Date') do
    pending # Write code here that turns the phrase above into concrete actions
end

Given('The trainee is registered for a Future Challenge {string} with start date of tomorrow') do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see tomorrows date') do
    pending # Write code here that turns the phrase above into concrete actions
end