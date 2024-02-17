# frozen_string_literal: true

FactoryBot.define do
  factory :challenge do
    name { 'MyString' }
    startDate { Date.today }
    endDate { Date.today + 1.week }
    instructor_id { nil }
  end
end
