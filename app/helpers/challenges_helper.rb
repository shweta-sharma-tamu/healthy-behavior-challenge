module ChallengesHelper
    def calculate_duration_in_days(start_date, end_date)
        (end_date - start_date).to_i
    end
end
