Given('today is {string}') do |current_date|
    # Set the current date for testing purposes
    # This can be used to simulate the current date in your scenarios
end

When('I update the challenge task list with the following tasks:') do |table|
    table.hashes.each_with_index do |row, index|
        within("#update-todo-list-form") do
            all('input[name^="todo_list[task_list]"]').each_with_index do |task_field, index|
                task_field.fill_in(with: table.hashes[index]['tasks'])
            end
        end
    end

    click_button 'Update Challenge'
end
  
Then('I should be redirected to the edit page for {string}') do |challenge_name|
    challenge = Challenge.find_by(name: challenge_name)

    expect(current_path).to eq(edit_todo_list_challenge_path(challenge))
end

Then('I should be redirected to the details page for {string}') do |challenge_name|
    challenge = Challenge.find_by(name: challenge_name)

    expect(current_path).to eq(challenge_path(challenge))
end
  