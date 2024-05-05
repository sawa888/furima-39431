class ItemsController < ApplicationController
  # ログインしていないユーザーはログインページへ遷移させる。
  before_action :authenticate_user!, except: [:index, :show]

  # ※N-1問題解決。一覧降順表示
  def index
    @items = Item.includes(:user).order('created_at DESC')
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if @item.user_id == current_user.id
    else
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :product_name, :present, :category_id, :condition_id, :delivery_charge_id,
                                 :shipping_address_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end
end
