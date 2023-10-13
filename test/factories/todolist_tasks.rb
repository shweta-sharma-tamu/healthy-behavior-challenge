FactoryBot.define do
  factory :todolist_task do
    task { nil }
    status { "MyString" }
    trainee { nil }
    challenge { nil }
    date { "2023-10-09" }
  end
end
