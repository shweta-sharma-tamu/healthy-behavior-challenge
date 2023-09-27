FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password { 'Admin@123' }
    user_type { 'Instructor' }
    id {  123 }
  end
end