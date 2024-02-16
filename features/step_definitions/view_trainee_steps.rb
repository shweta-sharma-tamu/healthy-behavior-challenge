Given("I have instructor access") do
  user = User.create!(email: 'instructor@example.com', password: 'abcdef', user_type: "Instructor")
  instructor = Instructor.create(user: user, first_name: 'John', last_name: 'Doe')

  visit root_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end

Given("I am on the homepage") do
  visit root_path
end

When("I click on the 'View Trainees' link") do
  click_link "View Trainees"
end

Then("I should be on the 'View Trainees' page") do
  expect(page).to have_current_path(view_trainees_path)
  expect(page).to have_content("View Trainees Page")
end


Given("I am on the \"View Trainees\" page with at least one trainee") do
  trainee_user = User.create!(email: 'trainee@example.com', password: 'password', user_type: "Trainee")
  Trainee.create!(user: trainee_user, full_name: "Trainee Name", height: 180, weight: 75)
  visit view_trainees_path
end

When("I click on the \"View Profile\" button for the first trainee") do
  first(:link, 'View Profile').click
end

Then("I should be on that trainee's profile details page") do
  expect(page).to have_current_path(trainee_profile_details_path(Trainee.first))
end

Given("I am on a trainee's profile details page") do
  user = User.create!(email: 'instructor@example.com', password: 'abcdef', user_type: "Instructor")
  instructor = Instructor.create(user: user, first_name: 'John', last_name: 'Doe')
  trainee_user = User.create!(email: 'trainee@example.com', password: 'password', user_type: "Trainee")
  trainee = Trainee.create!(user: trainee_user, full_name: "Trainee Name", height: 180, weight: 75)

  visit root_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'abcdef'
  click_button 'Sign In'

  visit view_trainees_path
  first(:link, 'View Profile').click
end


When("I click on the {string} button") do |button_text|
  click_link button_text
end

Then("I should be back on the {string} page") do |page_name|
  expected_path = case page_name
                  when "View Trainees" then view_trainees_path
                  else raise "Path to '#{page_name}' is not defined in steps."
                  end
  expect(page).to have_current_path(expected_path)
end