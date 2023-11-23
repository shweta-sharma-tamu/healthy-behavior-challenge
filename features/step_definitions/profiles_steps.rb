  Then("I should see the {string} profile button in the top right corner of the navigation bar") do |button_text|
    within('.navbar') do
      expect(page).to have_link(button_text)
    end
  end

  Given("I am logged in as an instructor") do
    user = User.create!(email: 'instructor@example.com', password: 'abcdef', user_type: "Instructor")
    instructor = Instructor.create(user: user, first_name: 'John', last_name: 'Doe')
  
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end
  
  When("I visit the instructor profile page") do
    visit profile_path
  end
  
  Then("I should see my email, first name, and last name") do
    expect(page).to have_content("instructor@example.com") 
    expect(page).to have_content("John") 
    expect(page).to have_content("Doe") 
  end
  
  And("I should be able to see {string} button") do |button_text|
    expect(page).to have_link(button_text)
  end
  
  When("I click on the displayed {string} button") do |button_text|
    click_on(button_text)
  end
  
  And("I fill in the new first name and last name") do
    fill_in "instructor_first_name", with: "NewJohn"
    fill_in "instructor_last_name", with: "NewDoe"
  end
  
  Then("I should see a success message") do
    expect(page).to have_content("Profile updated successfully")
  end
  
  And("I should see my updated first name and last name on the profile page") do
    expect(page).to have_content("NewJohn")
    expect(page).to have_content("NewDoe")
  end
  
  