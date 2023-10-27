Given('I am an instructor with following challenges:') do |table|
    user = User.create!(email: 'testInstructor@gmail.com', password: 'abcdef', user_type: "Instructor")
    @instructor = Instructor.create(user: user, first_name: 'John', last_name: 'Doe')

    table.hashes.each do |challenge|
        Challenge.create!(name: challenge['name'], startDate: challenge['startDate'], endDate: challenge['endDate'], instructor: @instructor, tasks_attributes: {
            '0' => { taskName: 'Task 1' },
            '1' => { taskName: 'Task 1' }  # Use a different name for the second task
          })
     end
end

Given('I am Logged in with username {string} and password {string}') do |string, string2|
    visit root_path
    fill_in 'Email', with: string
    fill_in 'Password', with: string2
    click_button 'Sign In'
end
  
When('I am on Homepage') do
    visit root_path
end
  
Then('I should see {string} and {string}') do |string, string2|
  expect(page).to have_content(string)
  expect(page).to have_content(string2)
end

Then('I should not see {string}') do |string|
  expect(page).to_not have_content(string)
end

And("I am in Past Challenges Page") do
  visit past_challenges_instructor_path @instructor.id
 end

And("I am in Upcoming Challenges Page") do
  visit upcoming_challenges_instructor_path @instructor.id
 end

Then('{string} should be before {string}') do |first_string, second_string|
    expect(page.body.index(first_string)).to be < page.body.index(second_string)
end
  