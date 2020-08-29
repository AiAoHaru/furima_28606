class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
# アソシエーション
    has_many :items
    has_many :comments, dependent: :destroy
    has_many :purchasers

# 正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
  VALID_NAME_READING_REGEX = /\A[ァ-ヶー－]+\z/.freeze

# エラーメッセージ
  ERROR_MESSAGE_EMAIL = "is invalid. Input email correctly."   # （メールアドレスを正しく入力してください）"
  ERROR_MESSAGE_PASSWORD = "is invalid. Include both letters and numbers."    # （パスワードは、半角英数字混合で入力してください）"
  ERROR_MESSAGE_NAME = "is invalid. Input Full-width characters."    # （お名前は、全角で入力してください）"
  ERROR_MESSAGE_NAME_READING = "is invalid. Input Full-width katakana characters."   # （お名前カナは、全角カナで入力してください）"

# バリデーション
  with_options presence: true do    # with_optionsで全てのバリデーションに共通したオプション（presence: true）をdo~endで指定したものに付ける
    validates :nickname, uniqueness: true   # 一意性を追加
    validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: ERROR_MESSAGE_EMAIL }
    validates :password, format: { with: VALID_PASSWORD_REGEX, message: ERROR_MESSAGE_PASSWORD }
    validates :family_name, format: { with: VALID_NAME_REGEX, message: ERROR_MESSAGE_NAME }
    validates :last_name, format: { with: VALID_NAME_REGEX, message: ERROR_MESSAGE_NAME }
    validates :family_name_reading, format: { with: VALID_NAME_READING_REGEX, message: ERROR_MESSAGE_NAME_READING }
    validates :last_name_reading, format: { with: VALID_NAME_READING_REGEX, message: ERROR_MESSAGE_NAME_READING }
    validates :birth_date
  end
end
