namespace :mail do
  desc "Todo reminder mail"
  task send_reminder_todos_mail: :environment do
    if defined?(Rails) && (Rails.env == 'development')
            Rails.logger = Logger.new(STDOUT)
    end
    trainee_ids = TodolistTask.where("date = ? AND status != ?", Date.today, "completed").distinct.pluck(:trainee_id)
    trainee_ids.each do |id|
        puts "Processing trainee_id: #{id}"
        @name = Trainee.find(id).full_name
        challenge_ids = TodolistTask.where("trainee_id = ? AND date = ? AND status != ?",id,Date.today, "completed").distinct.pluck(:challenge_id)
        @chmap = {}
        challenge_ids.each do |challenge_id|
            todos = TodolistTask.where("trainee_id = ? AND date = ? AND status != ? AND challenge_id=?",id,Date.today, "completed",challenge_id)
            challenge_name = Challenge.find(challenge_id).name
            todo_names = []
            todos.each do |todo|
                name = Task.find(todo.task_id).taskName
                todo_names << name
            end
            @chmap[challenge_name] = todo_names
        end
        @chmap.each do |key, values|
            puts "Key: #{key}, Values: #{values.join(', ')}"
        end
        trainee = Trainee.find(id)
        if trainee.user.present?
            trainee_email = trainee.user.email
            TodoReminderMailer.remind(@chmap,trainee_email,@name).deliver_now
        end
    end
  end
end