# frozen_string_literal: true

FactoryBot.define do
  factory :challenge_trainee do
    Trainee { nil }
    challenge { nil }
  end
end
