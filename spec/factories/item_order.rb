FactoryBot.define do
  factory :item_order do
    token { Faker::Code.nric }
    zip_code {'123-4567'}
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { '横浜市緑区' }
    house_number { '青山１−１−１' }
    building_name { '柳ビル１０３' }
    phone_number { Faker::PhoneNumber.subscriber_number(length: 11) }
  end
end