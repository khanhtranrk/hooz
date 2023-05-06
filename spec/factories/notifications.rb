FactoryBot.define do
  factory :notification do
    user_id { "" }
    message { "" }
    seen { false }
  end
end
