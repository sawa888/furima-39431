class Order < ApplicationRecord

  has_one :delivery_address
  belongs_to :user
  belongs_to :item
  
end
