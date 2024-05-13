class OrderDeliveryAddress

  # include を使用し、N+1問題解消
  include ActivModel::Model 
  # attr_accessor を使用し、保存したいカラム名を属性値として扱えるようにする
  attr_accessor :user_id, :item_id, :token, :postal_code, :shipping_address_id, :city, :street_address, :building_name, :phone_number, :order_id 
  
  # ordersテーブルとdelivery_addressesテーブルのバリデーションを記述(移動)
  
  
end

