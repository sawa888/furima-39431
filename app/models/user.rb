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
  validates :first_name, format: { with: /\A[一-龥々]+\z/, message: "苗字は全角漢字で入力してください" }
  validates :last_name, format: { with: /\A[一-龥々]+\z/, message: "名前は全角漢字で入力してください" }

  # 全角カナのバリデーション
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "苗字は全角カタカナで入力してください" }
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "名前は全角カタカナで入力してください" }

  # 英字と数字混合のバリデーション
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'passwordには英字と数字の両方を含めて設定してください' 


 
end


