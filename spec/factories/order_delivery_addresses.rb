FactoryBot.define do
  factory :order_delivery_address do
    # postal_code         { Faker::Number.number(digits: 3) + '-' + Faker::number(digits: 4) }
    postal_code         { '123-4567' }
    shipping_address_id { Faker::Number.between(from: 1, to: 47) }
    city                { Faker::Address.city }
    street_address      { Faker::Address.street_address }
    building_name       { '柳ビル' }
    # phone_number        { Faker::PhoneNumber.unique.cell_phone_in_e164.slice(0, 11) }
    phone_number        { '09012345678' }
    # phone_number        { 0 + Faker::Number.number(digits: rand(10..11)) }
    token               { 'tok_abcdefghijk00000000000000000' }
  end
end
