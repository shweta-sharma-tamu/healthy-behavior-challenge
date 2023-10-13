FactoryBot.define do
    factory :challenge do
      id {1}
      name { 'Test Challenge 1' }
      startDate { Date.current + 3.days } # Modify this to match your requirements
      endDate { Date.current + 10.days }   # Modify this to match your requirements
    end
  end