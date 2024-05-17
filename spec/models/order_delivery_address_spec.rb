require 'rails_helper'

RSpec.describe OrderDeliveryAddress, type: :model do

  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_delivery_address = FactoryBot.build(:order_delivery_address, user_id: user.id, item_id: item.id)
  end

  describe '配送先情報の登録' do
    context '配送先情報が登録できるとき' do
      it '全ての値が正しく入力されていれば登録できる' do
        expect(@order_delivery_address).to be_valid
      end
      it 'user_idが空でなければ登録できる' do
        @order_delivery_address.user_id = 1
        expect(@order_delivery_address).to be_valid
      end
      it 'item_idが空でなければ登録できる' do
        @order_delivery_address.item_id = 1
        expect(@order_delivery_address).to be_valid
      end
      it '郵便番号が「3桁+ハイフン+4桁」であれば登録できる' do
        @order_delivery_address.postal_code = "987-6543"
        expect(@order_delivery_address).to be_valid
      end
      it '都道府県が空でない事と、「---」でなければ登録できる' do
        @order_delivery_address. shipping_address_id = 1
        expect(@order_delivery_address).to be_valid
      end
      it '市区町村が空でなければ登録できる' do
        @order_delivery_address.city = "東京都"
        expect(@order_delivery_address).to be_valid
      end
      it '番地が空でなければ登録できる' do
        @order_delivery_address.street_address = "港区1-1-1"
        expect(@order_delivery_address).to be_valid
      end
      it '建物名が空でも登録できる' do
        @order_delivery_address.building_name = ""
        expect(@order_delivery_address).to be_valid
      end
      it '電話番号が11桁以内かつ、ハイフンなしであれば登録出来る' do
        @order_delivery_address.phone_number = 12345678900
        expect(@order_delivery_address).to be_valid
      end
    end
    context '配送先情報が登録できないとき' do
      it 'user_idが空では登録できない' do
        @order_delivery_address.user_id = nil
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "User can't be blank" )
      end
      it 'item_idが空では登録出来ない' do
        @order_delivery_address.item_id = nil 
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Item can't be blank" )
      end
      it '郵便番号が空では登録出来ない' do
        @order_delivery_address.postal_code = ""
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Postal code can't be blank" )
      end
      it '郵便番号にハイフンが無いと登録できない' do
        @order_delivery_address.postal_code = "1234567"
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Postal code is invalid. Enter it as follows (e.g. 123-4567)" )
      end
      it '都道府県が「---」だと登録できない' do
        @order_delivery_address.shipping_address_id = 0
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Shipping address can't be blank" )
      end
      it '市区町村が空では登録出来ない' do
        @order_delivery_address.city = ""
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "City can't be blank" )
      end
      it '番地が空では登録出来ない' do
        @order_delivery_address.street_address = ""
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Street address can't be blank" )
      end
      it '電話番号が9桁以下では登録できない' do
        @order_delivery_address.phone_number = "123456789"
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Phone number is invalid" )
      end
      it '電話番号が12桁以上では登録できない' do
        @order_delivery_address.phone_number = "123456789012"
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Phone number is invalid" )
      end
      it '電話番号にハイフンがあると登録出来ない' do
        @order_delivery_address.phone_number = "123-456-789"
        @order_delivery_address.valid?
        expect(@order_delivery_address.errors.full_messages).to include( "Phone number is invalid" )
      end
    end
  end
end
