FactoryBot.define do
  factory :comment do
    content { "My_Comment" }
    association :article
    association :user
  end
end
