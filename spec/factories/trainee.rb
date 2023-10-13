FactoryBot.define do
    factory :trainee do
      full_name { 'Test Trainee' }
      height { 1.75 }  # Modify this to match your requirements
      weight { 70.0 }  # Modify this to match your requirements
      user_id { 1 }
      created_at { Date.current }
      updated_at { Date.current }
    end
  end