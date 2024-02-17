# frozen_string_literal: true

Given('I am on the trainee profile') do
  visit trainee_profile_path
end

Then('I should be on root path') do
  expect(current_path).to eq(root_path)
end
