FactoryBot.define do
    factory :trainee do
      id {1}
      full_name { 'Test Trainee' }
      height { 1.75 }  # Modify this to match your requirements
      weight { 70.0 }  # Modify this to match your requirements
      user_id { 1 }
    end
  end