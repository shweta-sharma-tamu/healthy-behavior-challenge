When('I visit the edit page for challenge {string}') do |string|
    challenge = Challenge.find_by(name: string)
    visit "/challenges/#{challenge.id}/edit"
end

Then('I should see the Challenge Start Date as {string}') do |string|
    start_date_element = find('#start_date')

    actual_date = start_date_element.value || start_date_element.text

    expect(actual_date).to eq(string)
end

Then('I should see the Challenge End Date as {string}') do |string|
    end_date_element = find('#end_date')

    actual_date = end_date_element.value || end_date_element.text

    expect(actual_date).to eq(string)
end
