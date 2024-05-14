class OrderDeliveryAddress

  # include を使用し、N+1問題解消
  include ActivModel::Model 
  # attr_accessor を使用し、保存したいカラム名を属性値として扱えるようにする
  attr_accessor :user_id, :item_id, :token, :postal_code, :shipping_address_id, :city, :street_address, :building_name, :phone_number, :order_id 
  
  # ordersテーブルとdelivery_addressesテーブルのバリデーションを記述(移動)
  with_options presence: true do 

    # orderテーブルのバリデーション
    validates :user,                foreign_key: true
    validates :item,                foreign_key: true

    # delivery_addressテーブルのバリデーション
    # 半角数字３文字＋ハイフン「-」＋半角数字４文字のバリデーション
    validates :postal_code,         format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
    # ActiveHashの添え字「０」を許可しないバリデーション
    validates :shipping_address_id, numericality: { other_than: 0 }
    validates :city             
    validates :street_address    
    validates :phone_number      
    validates :order,               foreign_key: true

  end

  def save
    # 商品情報(order情報)を保存し、変数orderに代入する。
    oeder = Order.create(user_id: user_id, item_id: item_id)
    # 上記で、変数orderが生成され、「order.id」が生成される。
    # ストロングパラメーターにて、order_idカラムに「order.id」を保存できるようになる。
    delivery_address.create(order_id: order.id, postal_code: postal_code, shipping_address_id: shipping_address_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number)
  end
  
end

  






end
