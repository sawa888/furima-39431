class Item < ApplicationRecord

  belongs_to :user
  # has_one :order

  validates :product_name, presence: true
  validates :present, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :shipping_address_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true
  validates :user, presence: true, foreign_key: true


end
