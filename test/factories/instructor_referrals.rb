FactoryBot.define do
  factory :instructor_referral do
    token { "MyString" }
    expires { "2023-09-27 05:13:24" }
    is_used { false }
    user { nil }
  end
end
