FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    family_name { '鈴木' }
    last_name { '一郎' }
    family_name_reading { 'スズキ' }
    last_name_reading { 'イチロウ' }
    email {Faker::Internet.free_email}
    password { '1Aa'+Faker::Internet.password(min_length: 6) }
    password_confirmation {password}
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end


# ※参考※
# 上記10~12行目と同じ結果になるコードの記法（クライアントなどにわかりやすく説明するためにあえて可読性をあげた記表も実際の現場ではある）
# password = Faker::Internet.password(min_length: 6)
# password {password}
# password_confirmation {password}

# Fakerでパスワードを生成する際は、全て英字のみになるケースも存在する。パスワードで英数字混合のテストを実行する際は、9行目のように 「 '1Aa'+ 」と記載を足してあげることで、ランダム生成に足すことができる。