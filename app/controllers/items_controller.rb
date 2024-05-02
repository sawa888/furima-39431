class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]


  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :product_name, :present, :category_id, :condition_id, :delivery_charge_id, :shipping_address_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end

  

end
