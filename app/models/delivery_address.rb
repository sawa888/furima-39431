class DeliveryAddress < ApplicationRecord
  belongs_to :order

  # order_delivery_address.rbへ移動
  # 半角数字３文字＋ハイフン「-」＋半角数字４文字のバリデーション
  # validates :postal_code,         presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
  # ActiveHashの添え字「０」を許可しないバリデーション
  # validates :shipping_address_id, presence: true, numericality: { other_than: 0 }
  # validates :city,                presence: true
  # validates :street_address,      presence: true
  # validates :phone_number ,       presence: true
  # validates :order ,              presence: true, foreign_key: true
end
