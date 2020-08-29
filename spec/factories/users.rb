FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    family_name { '鈴木' }
    last_name { '一郎' }
    family_name_reading { 'スズキ' }
    last_name_reading { 'イチロウ' }
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end