When('I visit the edit page for challenge {string}') do |string|
    challenge = Challenge.find_by(name: string)
    visit "/challenges/#{challenge.id}/edit_todo_list"
end

Then('I should see the Challenge Start Date as {string}') do |string|
    expect(page).to have_content("#{string}")
end

Then('I should see the Challenge End Date as {string}') do |string|
    expect(page).to have_content("#{string}")
end

