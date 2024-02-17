# frozen_string_literal: true

FactoryBot.define do
  factory :todolist_task do
    task { nil }
    status { 'not_completed' }
    trainee { nil }
    challenge { nil }
    date { '2023-10-09' }
  end
end
