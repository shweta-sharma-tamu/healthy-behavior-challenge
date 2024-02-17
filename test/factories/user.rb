# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'Admin@gmail.com' }
    password { 'Admin@123' }
    user_type { 'Instructor' }
  end
end
