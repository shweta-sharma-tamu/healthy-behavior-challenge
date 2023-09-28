  Given(/^I am on instructor signup page$/) do
    visit '/instructor_signup'
    expect(page).to have_content('Sign up')
  end
  
  When('I fill in email with instructorsignup3@gmail.com') do
    fill_in 'Email', with: 'instructorsignup3@gmail.com'
  end

  When('I fill in email with {string}') do |email|
    fill_in 'Email', with: email
  end

  When('I fill in email with instructorsignup') do
    fill_in 'Email', with: 'instructorsignup'
  end

  When('I fill in email with '' ') do
    fill_in 'Email', with: ''
  end

  When('I fill in password with signup111') do
    fill_in 'Password', with: 'signup111'
  end

  When('I fill in password with {string}') do |password|
    fill_in 'Password', with: password
  end

  When('I fill in password with ''') do
    fill_in 'Password', with: ''
  end

  When('I fill in confirm_password with signup111') do
    fill_in 'Confirm Password', with: 'signup111'
  end

  When('I fill in confirm_password with signup123') do
    fill_in 'Confirm Password', with: 'signup123'
  end

  When('I fill in confirm_password with {string}') do |confirm_password|
    fill_in 'Confirm Password', with: confirm_password
  end

  When('I fill in first_name with Peter') do
    fill_in 'First Name', with: 'Peter'
  end

  When('I fill in last_name with John') do
    fill_in 'Last Name', with: 'John'
  end

  When('I fill in referral_code with ABC') do
    fill_in 'Referral Code', with: 'ABC'
  end

  When('I fill in referral_code with {string}') do |referral_code|
    fill_in 'Referral Code', with: referral_code
  end
  
  When("I click on signup") do
    click_button "Sign Up"
  end
  
  #Then('I should see {string}') do
    #expect(page).to have_content("Welcome!, #{@first_name} #{@last_name}")
  #end

  Then('I should see {string} message') do |msg|
    expect(page).to have_content(msg)
  end

  Then('I should see error {string}') do
    expect(page).to have_content("Email cannot be empty")
  end

  Then('I should see error {string}') do
    expect(page).to have_content("Password cannot be empty")
  end  