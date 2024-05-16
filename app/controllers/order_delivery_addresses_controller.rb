class OrderDeliveryAddressesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_order_delivery_address, only: [:index, :create]

 def index
  @order_delivery_address = OrderDeliveryAddress.new
 end

 def create
  # binding.pry
  @order_delivery_address = OrderDeliveryAddress.new(order_delivery_address_params)
  if @order_delivery_address.valid?
    @order_delivery_address.save
    redirect_to root_path
  else
    render :index, status: :unprocessable_entity 
  end
end


private 

  def order_delivery_address_params
    # この時点では、まだ商品を購入していない為(購入画面は確定ではない)、order_id は不要
    params.require(:order_delivery_address).permit(:postal_code, :shipping_address_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_order_delivery_address
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

end