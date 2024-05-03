FactoryBot.define do
  factory :item do
    
    association :user

    product_name        {"商品名テスト"}
    present             {"商品の説明テスト"}
    category_id         {Faker::Number.between(from: 1, to: 10)}
    condition_id        {Faker::Number.between(from: 1, to: 6)}
    delivery_charge_id  {Faker::Number.between(from: 1, to: 2)}
    shipping_address_id {Faker::Number.between(from: 1, to: 47)}
    delivery_time_id    {Faker::Number.between(from: 1, to: 3)}
    price               {Faker::Number.between(from: 300, to: 9_999_999)}

    # テストコード用の画像ファイル
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end





