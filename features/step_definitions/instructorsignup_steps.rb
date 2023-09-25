  Given(/^I am on instructor signup page$/) do
    visit '/instructorsignup'
  end
  
  When('I fill in email with {string}') do |email|
    fill_in 'email', with: 'email'
  end

  When('I fill in email with ''') do
    fill_in 'email', with: ''
  end

  When('I fill in first name with {string}') do |first_name|
    fill_in 'first_name', with: 'first_name'
    @first_name = first_name
  end

  When('I fill in last name with {string}') do |last_name|
    fill_in 'last_name', with: 'last_name'
    @last_name = last_name
  end

  When('I fill in password with {string}') do |password|
    fill_in 'password', with: 'password'
  end

  When('I fill in confirm_password with {string}') do |confirm_password|
    fill_in 'confirm_password', with: 'confirm_password'
  end

  When('I fill in referal_code with {string}') do |referral_code|
    fill_in 'referral_code', with: 'referral_code'
  end
  
  When("I click on signup button") do |button_text|
    click_button button_text
  end
  
  Then('I should see {string}') do
    expect(page).to have_content("Welcome!, #{@first_name} #{@last_name}")
  end

  Then('I should see error {string}') do
    expect(page).to have_content("Email cannot be empty")
  end

  Then('I should see error {string}') do
    expect(page).to have_content("Password cannot be empty")
  end  