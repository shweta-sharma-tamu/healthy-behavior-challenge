FactoryBot.define do
    factory :challenge1 do
      name { 'Test Challenge 1' }
      startDate { Date.current + 3.days } # Modify this to match your requirements
      endDate { Date.current + 10.days }   # Modify this to match your requirements
      instructor
      created_at { Date.current }
      updated_at { Date.current }
    end
  end