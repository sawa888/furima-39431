class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :items

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_day, presence: true

  # 漢字のバリデーション
  validates :first_name, format: { with: /\A[一-龥々]+\z/, message: 'is invalid. Input full-width characters' }
  validates :last_name, format: { with: /\A[一-龥々]+\z/, message: 'is invalid. Input full-width characters' }

  # 全角カナのバリデーション
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }

  # 英字と数字混合のバリデーション
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: ' is invalid. Include both letters and numbers'
end
