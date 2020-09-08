FactoryBot.define do
  factory :purchaser do
    association :user
    association :item
  end
end
