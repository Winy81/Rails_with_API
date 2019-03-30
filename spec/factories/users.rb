FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "jdo #{n}" }
    name { "John Do" }
    url { "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "GitHub" }
  end
end
