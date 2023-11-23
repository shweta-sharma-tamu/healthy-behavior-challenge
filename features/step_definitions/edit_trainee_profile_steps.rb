Then('I should be on edit profile path') do
  expect(current_path).to eq(edit_trainee_profile_path)
end
  
When ("I fill in 'Full name' with 'New Trainee'") do
  fill_in 'trainee[full_name]', with: 'New Trainee'
end
  
When("I fill in 'Height' with '110'") do
  fill_in 'trainee[height]', with: '110'
end
  
When("I fill in 'Weight' with '100'") do
  fill_in 'trainee[weight]', with: '100'
end
  
Then('I should be on trainee profile path') do
  expect(current_path).to eq(trainee_profile_path)
end