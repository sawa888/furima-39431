class Item < ApplicationRecord
  # ActiveHash のアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :shipping_address
  belongs_to :delivery_time

  # テーブルとのアソシエーション
  belongs_to :user
  # has_one :order
  
  # active_storageとのアソシエーション
  has_one_attached :image


  # バリデーション
  validates :product_name, presence: true
  validates :present, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :shipping_address_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true
  # validates :user_id, presence: true, foreign_key: true
  validates :user_id, presence: true

  # 画像が１枚無いと保存出来ないバリデーション
  validates :image, presence: true

  # 「価格は、¥300~¥9,999,999の間のみ保存可能である」のバリデーション
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # 「価格は半角数値のみ保存可能であること」のバリデーション
  validates :price, numericality: { only_integer: true }

  # ActiveHashのバリデーション
  #ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, numericality:{ other_than: 0 }
  validates :condition_id, numericality:{ other_than: 0 }
  validates :delivery_charge_id, numericality:{ other_than: 0 }
  validates :shipping_address_id, numericality:{ other_than: 0 }
  validates :delivery_time_id, numericality:{ other_than: 0 ,message: "can't be blank" }



end
