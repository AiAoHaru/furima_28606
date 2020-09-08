class Address < ApplicationRecord
  # アソシエーション
  belongs_to :purchaser

  # Active Hash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture


  # 正規表現
  VALID_ZIP_CODE_REGEX = /\A\d{3}[-]\d{4}\z/.freeze   # 郵便番号（「-」を含む且つ7桁）  # /\A[0-9]{3}-[0-9]{4}\z/i 
  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/.freeze   # 携帯番号(「-」無し10桁or11桁)
  # VALID_NAME_REGEX = /\A[ぁ-んァ-ンー-龥]+\z/i.freeze   # 全角ひらがな、全角カタカナ、漢字



  # エラーメッセージ
  ERROR_MESSAGE_SELECT_LIST = "Select an item from a list."   # （リストから選択してください）"


  # バリデーション（今回の実装では、コードの並び順がエラーメッセージの並び順に影響する）
  with_options presence: true do    # with_optionsで全てのバリデーションに共通したオプション（presence: true）をdo~endで指定したものに付ける
    validates :zip_code, format: {with: VALID_ZIP_CODE_REGEX}
    validates :prefecture_id, numericality: { other_than: 0, message: ERROR_MESSAGE_SELECT_LIST}  # ActiveHashの選択が「--」の時は保存できないようにする
    validates :city
    validates :house_number
    validates :phone_number, format: {with: VALID_PHONE_NUMBER_REGEX}
  end

end
