Given('today is {string}') do |current_date|
    @current_date = Date.parse(current_date)
    Timecop.freeze(@current_date)
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

    expect(current_path).to eq(edit_challenge_path(challenge))
end

Then('I should be redirected to the details page for {string}') do |challenge_name|
    challenge = Challenge.find_by(name: challenge_name)

    expect(current_path).to eq(challenge_path(challenge))
end

When('I select the start date as {string}') do |date|
    fill_in 'start_date', with: date
end

After do
    Timecop.return
end
