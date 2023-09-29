Given("there is a instructor registered with the email {string} and password {string}") do |email,password|
    @user = User.create!(email: email, password: password,user_type: "Instructor")
    puts @user.email
end

Given("I am logged in as an instructor with email {string} and password {string}") do |email,password|
    # Implement the code to log in as an instructor
    visit login_path
    expect(page).to have_content('User Sign in')
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign In'
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
    puts @token
    expect(page).to have_content(@token)
  end
  
  Given("I receive a referral link from {string}") do |email|
    @token = SecureRandom.uuid
    user = User.find_by(email: email)
    # Create a new referral associated with the user
    referral = user.instructor_referrals.create(email: "example@example.com", token: @token, is_used: false,expires: Date.today+7.days)
    @referral_link = instructor_signup_path(token: @token)
    
  end
  
  When("I click the referral link") do
    # Implement the code to click the referral link
    visit @referral_link
  end
  
  Then("I should be redirected to the signup page") do
    # Implement the code to verify that the user is redirected to the signup page
    expect(page).to have_content("Sign up")
  end


    Given("I have an invalid link") do
    @token = SecureRandom.uuid
    @referral_link = instructor_signup_path(token: @token) 
  end

  Given("I have an expired link from {string}") do |email|
     @token = SecureRandom.uuid
    user = User.find_by(email: email)
    referral = user.instructor_referrals.create(email: "example@example.com", token: @token, is_used: false,expires: Date.today-7.days)
    @referral_link = instructor_signup_path(token: @token)
  end


  Then("I should see invalid error") do
    # Implement the code to verify that the user is redirected to the signup page
    expect(page).to have_content("Token is invalid")
  end

Then("Instructor Referral: Errors are displayed") do
    # Implement the code to verify that the user is redirected to the signup page
    expect(page).to have_content("Error")
  end
  

  