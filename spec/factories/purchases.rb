FactoryBot.define do
  factory :purchase do
    user_id { "" }
    plan_id { "" }
    effective_date { "2023-05-06 23:32:39" }
    expiry_date { "2023-05-06 23:32:39" }
    payment_method { "MyString" }
    status { "MyString" }
  end
end
