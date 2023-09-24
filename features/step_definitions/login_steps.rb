Given(/^I am not currently Logged in$/) do
  visit login_path
  expect(page).to have_content('Please Log in')
end

Given(/^I am on the Login page$/) do
  visit login_path
end

When('I enter Admin@gmail.com as email') do
  fill_in 'email', with: 'Admin@gmail.com'
end

When('I enter {string} as email') do |string|
  fill_in 'email', with: string
end

When('I enter '' as email') do
  fill_in 'email', with: ''
end

When('I enter Admin@123 as password') do
  fill_in 'password', with: 'Admin@123'
end

When('I enter '' as password') do
  fill_in 'password', with: ''
end

When('I enter {string} as password') do |string|
  fill_in 'password', with: string
end

When('I enter abcd@123 as password') do
  fill_in 'password', with: 'abcd@123'
end

When('I click on submit') do
  click_button 'Sign In!'
end

Then('I should see {string}') do |arg|
  expect(page).to have_content(arg)
end


