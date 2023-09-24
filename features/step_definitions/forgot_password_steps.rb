# features/step_definitions/forgot_password_steps.rb

# features/step_definitions/password_reset_steps.rb

Given('there is a registered user with the email {string}') do |email|
    # Create a user with the given email in your test database or use FactoryBot or similar.
    # Make sure the user is saved and can be used for testing.
    User.create!(email: email, password: 'password') # Example assuming User is your model
  end
  
  Given('I am on the login page') do
    visit root_path # Adjust the path as needed
  end
  
  When('I click on the "Forgot Password" link') do
    click_link 'Forgot your password?' # Adjust the link text as needed
  end
  
  When('I fill in my email address with {string}') do |email|
    fill_in 'Email', with: email # Assuming the input field has a label or name "Email"
  end
  
  When('I click the "Reset Password" button') do
    click_button 'Reset Password' # Adjust the button text as needed
  end
  
  Then('I should see a message {string}') do |message|
    expect(page).to have_content(message)
  end
  
  Then('I should be on the login page') do
    expect(current_path).to eq(root_path) # Adjust the path based on your application
  end
  
  Then('I should see an error message {string}') do |error_message|
    expect(page).to have_content(error_message)
  end
  
  
  When('I fill in a new password with {string}') do |new_password|
    fill_in 'Password', with: new_password # Assuming your password field has the label or name "Password"
  end
  
  When('I fill in the password confirmation with {string}') do |password_confirmation|
    fill_in 'Password Confirmation', with: password_confirmation # Adjust the field name as needed
  end
  