FactoryBot.define do
  factory :session do
    user_id { "" }
    refresh_token { "MyString" }
    access_token { "MyString" }
    expire_at { "2023-05-06 21:55:55" }
  end
end
