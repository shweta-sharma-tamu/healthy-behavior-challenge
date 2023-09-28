Given("there is a instructor registered with the email {string} and password {string}") do |email,password|
    @user = User.create!(email: email, password: password,user_type: "Instructor")
end

Given("I am logged in as an instructor with email {string} and password {string}") do |email,password|
    # Implement the code to log in as an instructor
    visit login_path
    expect(page).to have_content('Please Log in')
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign In!'
    expect(page).to have_content("Welcome")
  end
  
  When("I navigate to the referral page") do
    # Implement the code to navigate to the referral page
    visit instructor_referral_path
    expect(page).to have_content("Please enter valid email to refer an instructor.")
  end
  
  And("I fill in the recipient's email with {string}") do |recipient_email|
    # Implement the code to fill in the recipient's email field with the provided email
    @recipient_email = recipient_email
    fill_in 'email',with: recipient_email
  end
  
  And("Instructor Referral: I click the {string} button") do |button_text|
    # Implement the code to click the specified button
    find("#refer-button").click
  end
  
  Then("a unique referral link should be generated and displayed") do
    # Implement the code to verify that a unique referral link was generated and sent to the recipient's email
    puts @user.email
    @token = InstructorReferral.where(email: @recipient_email).order(created_at: :desc).first.token
    expect(page).to have_content(@token)
  end
  
  And("the unique referral link should be sent to {string}") do |email|
    # Implement the code to verify that a success message is displayed
  end
  
  Given("I receive a referral email with a unique link") do
    # Implement the code to simulate receiving a referral email with a unique link
  end
  
  When("I click the referral link") do
    # Implement the code to click the referral link
  end
  
  Then("I should be redirected to the signup page") do
    # Implement the code to verify that the user is redirected to the signup page
  end
  
  And("the referral code should be associated with my account") do
    # Implement the code to verify that the referral code is associated with the user's account
  end
  