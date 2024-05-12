class OrderDeliveryAddress

  include ActivModel::module 
  attr_accessor :user_id, :item_id, :token, :postal_code, :shipping_address_id, :city, :street_address, :building_name, :phone_number, :order_id 
  
  end
  
end

