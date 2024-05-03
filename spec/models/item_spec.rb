require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品が登録出来るとき' do
      it '全ての項目が存在すれば、登録できる' do
        expect(@item).to be_valid
      end
      it 'カテゴリーが「---」以外であれば登録できる' do
        @item.category_id = "1"
        expect(@item).to be_valid
      end
      it '商品の状態が「---」以外であれば登録できる' do
        @item.condition_id = "1"
        expect(@item).to be_valid
      end
      it '配送料の負担が「---」以外であれば登録できる' do
        @item.delivery_charge_id = "1"
        expect(@item).to be_valid
      end
      it '発送先の地域が「---」以外であれば登録できる' do
        @item.shipping_address_id = "1"
        expect(@item).to be_valid
      end
      it '発送までの日数が「---」以外であれば登録できる' do
        @item.delivery_time_id = "1"
        expect(@item).to be_valid
      end
      it '販売価格が「¥300～9,999,999」の間であれば登録できる' do
        @item.price = 1000
        expect(@item).to be_valid
      end  
    end
    context '商品が登録出来ないとき' do
      it "ログインしているユーザー以外は登録できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it "1枚画像がないと登録出来ない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it " カテゴリーが空では登録出来ない" do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it " カテゴリーが「---」では登録出来ない" do
        @item.category_id = "0"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it "商品の状態が空では登録出来ない" do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it "商品の状態が「---」では登録出来ない" do
        @item.condition_id = "0"
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 0")
      end
      it "配送料の負担が空では登録出来ない" do
        @item.delivery_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it "配送料の負担が「---」では登録出来ない" do
        @item.delivery_charge_id = "0"
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge must be other than 0")
      end
      it "発送先の地域が空では登録出来ない" do
        @item.shipping_address_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping address can't be blank")
      end
      it "発送先の地域が「---」では登録出来ない" do
        @item.shipping_address_id = "0"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping address must be other than 0")
      end
      it "発送までの日数が空では登録出来ない" do
        @item.delivery_time_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end
      it "発送までの日数が「---」では登録出来ない" do
        @item.delivery_time_id = "0"
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end
      it "販売価格が空では登録出来ない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "販売価格が300円未満だと登録出来ない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it "販売価格が9,999,999円以上だと登録出来ない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end

