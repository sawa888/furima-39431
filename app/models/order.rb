class Order < ApplicationRecord

  has_one :delivery_address
  belongs_to :user
  belongs_to :item

  # order_delivery_address.rbへ移動
  # validates :user, presence: true, foreign_key: true
  # validates :item, presence: true, foreign_key: true

end
