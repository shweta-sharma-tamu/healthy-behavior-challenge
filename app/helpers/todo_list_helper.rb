module TodoListHelper
    def best_days(challenge_id, trainee_id)
        @challenge = Challenge.find_by(id: challenge_id)
        
        if @challenge.startDate <= Date.today
            if @challenge.endDate < Date.today
                end_date = @challenge.endDate
            else
                end_date = Date.today
            end

            start_date = @challenge.startDate
        else
            return 0
        end

        counter = 0
        (start_date..end_date).each do |date|
            tasks = TodolistTask.where(challenge_id: challenge_id, trainee_id: trainee_id, date: date)
            
            if tasks.all? { |task| task.status == 'completed' }
                counter += 1
            end
        end

        return counter
    end
end
