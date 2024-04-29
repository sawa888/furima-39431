FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.email}
    # paaawordが英数字になるように、「'la'」を追加記述
    password              {'la' + Faker::Internet.unique.password(min_length: 6)}
    password_confirmation {password}
    last_name             {'太郎'}
    first_name            {'山田'}
    last_name_kana        {'タロウ'}
    first_name_kana       {'ヤマダ'}
    birth_day             {Faker::Date.birthday}
  end
end
