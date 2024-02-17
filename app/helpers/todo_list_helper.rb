# frozen_string_literal: true

module TodoListHelper
  def best_days(challenge_id, trainee_id)
    @challenge = Challenge.find_by(id: challenge_id)

    return 0 unless @challenge.startDate <= Date.today

    end_date = if @challenge.endDate < Date.today
                 @challenge.endDate
               else
                 Date.today
               end

    start_date = @challenge.startDate

    counter = 0
    (start_date..end_date).each do |date|
      tasks = TodolistTask.where(challenge_id:, trainee_id:, date:)

      counter += 1 if tasks.all? { |task| task.status == 'completed' }
    end

    counter
  end
end
