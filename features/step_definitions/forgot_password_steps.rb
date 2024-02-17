# frozen_string_literal: true

# features/step_definitions/forgot_password_steps.rb

# features/step_definitions/password_reset_steps.rb

Given('there is a registered user with the email {string}') do |email|
  User.create!(email:, password: 'password')
end

Given('I am on the login page') do
  visit root_path
end

When('I click on the "Forgot Password" link') do
  click_link 'Forgot your password?'
end

When('I fill in my email address with {string}') do |email|
  fill_in 'Email', with: email
end

Then('I should be on the login page') do
  expect(current_path).to eq(root_path)
end

Then('I should see an error message {string}') do |error_message|
  expect(page).to have_content(error_message)
end

When('I fill in a new password with {string}') do |new_password|
  fill_in 'Password', with: new_password
end

When('I fill in the password confirmation with {string}') do |password_confirmation|
  fill_in 'Password Confirmation', with: password_confirmation
end

Given('a valid password reset token') do
  @user = User.first || User.create!(email: 'admin@gmail.com', password: 'password')
  @token = @user.signed_id(purpose: 'password_reset')
end

Given('an expired password reset token') do
  @token = 'fsafaf'
end

When('I visit the password reset edit page with the token') do
  visit password_reset_edit_path(token: @token)
end

Then('I should see the password reset form') do
  expect(page).to have_selector('form')
end

Then('I should see a field labeled {string}') do |field_label|
  expect(page).to have_selector('label', text: field_label)
end

Then('I should see a button labeled {string}') do |button_label|
  expect(page).to have_button(button_label)
end

Then('I should be redirected to the root page with an error message') do
  expect(current_path).to eq(root_path)
  expect(page).to have_content('Your token has expired. Please try again.')
end

Then('I should be redirected to the root page with a success message') do
  expect(current_path).to eq(root_path)
  expect(page).to have_content('Your password was reset successfully. Please sign in.')
end

Then('I should see an error message on the edit page') do
  expect(page).to have_css('.alert')
end

When('I fill in password_confirmation with {string}') do |confirm_password|
  fill_in 'Password confirmation', with: confirm_password
end
