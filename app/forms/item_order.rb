class ItemOrder

  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :item_id, :purchaser_id#,:price


# 正規表現
  # Addressに関する正規表現
  VALID_ZIP_CODE_REGEX = /\A\d{3}[-]\d{4}\z/.freeze   # 郵便番号（「-」を含む且つ7桁）  # /\A[0-9]{3}-[0-9]{4}\z/i 
  VALID_NAME_REGEX = /\A[ぁ-んァ-ンー-龥]+\z/i.freeze   # 全角ひらがな、全角カタカナ、漢字
  VALID_PHONE_NUMBER_REGEX = /\A[0-9]{11}\z/i.freeze   # 電話番号（半角数字で11桁）


# エラーメッセージ
  # Addressに関するエラーメッセージ
  ERROR_MESSAGE_SELECT_LIST = "Select an item from a list."   # （リストから選択してください）"


# バリデーション
  # Addressに関するバリデーション
  with_options presence: true do    # with_optionsで全てのバリデーションに共通したオプション（presence: true）をdo~endで指定したものに付ける
    validates :zip_code, format: {with: VALID_ZIP_CODE_REGEX}
    validates :prefecture_id, numericality: { other_than: 0, message: ERROR_MESSAGE_SELECT_LIST}  # ActiveHashの選択が「--」の時は保存できないようにする
    validates :city
    validates :house_number
    validates :phone_number, format: {with: VALID_PHONE_NUMBER_REGEX}
  end

  

  def save
    # 購入者情報の保存
    purchaser = Purchaser.create!(item_id: item_id, user_id: user_id)
    # 配送先情報の保存
    Address.create!(zip_code: zip_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchaser_id: purchaser.id)
  end

end