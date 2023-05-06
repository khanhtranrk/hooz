FactoryBot.define do
  factory :verification do
    code { "MyString" }
    expire_at { "2023-05-06 22:35:41" }
    user_id { "" }
  end
end
