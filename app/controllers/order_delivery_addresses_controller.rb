class OrderDeliveryAddressesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_order_delivery_address, only: [:index, :create]

 def index
  if current_user.id != @item.user_id && @item.order.nil?
  else
    redirect_to root_path
  end
  gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  @order_delivery_address = OrderDeliveryAddress.new
 end

 def create
  # if current_user.id != @item.user_id && @item.order.nil?
  # else
  #   redirect_to root_path
  # end
  # binding.pry
  @order_delivery_address = OrderDeliveryAddress.new(order_delivery_address_params)
  if @order_delivery_address.valid?
    pay_item
    @order_delivery_address.save
    redirect_to root_path
  else
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    render :index, status: :unprocessable_entity 
  end
  
end


private 

  def order_delivery_address_params
    # この時点では、まだ商品を購入していない為(購入画面は確定ではない)、order_id は不要
    params.require(:order_delivery_address).permit(:postal_code, :shipping_address_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_order_delivery_address
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = "sk_test_509dc7eea265763ee099e808"  # 自身のPAY.JPテスト秘密鍵を記述
    # 決済処理
    Payjp::Charge.create(
      amount: @item.price,                            # 商品の値段
      card: order_delivery_address_params[:token],    # カードトークン
      currency: 'jpy'                                 # 通貨の種類（日本円）
    )
  end

end