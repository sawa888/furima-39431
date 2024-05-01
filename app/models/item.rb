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



  validates :product_name, presence: true
  validates :present, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :shipping_address_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true
  validates :user, presence: true, foreign_key: true
  validates :image, presence: true


end
