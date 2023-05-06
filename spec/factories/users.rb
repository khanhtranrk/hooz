FactoryBot.define do
  factory :user do
    email { "MyString" }
    password { "MyString" }
    firstname { "MyString" }
    lastname { "MyString" }
    birthday { "MyString" }
    role { 1 }
    locked { false }
  end
end
