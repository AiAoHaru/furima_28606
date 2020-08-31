class Item < ApplicationRecord
# アソシエーション
  belongs_to :user
  has_one :purchaser

  # ActiveStorage
  has_one_attached :image

  # Active Hash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :handling_time
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture



# 正規表現
# VALID_PRICE_REGEX = /\A[0-9]+\z/.freeze    # 半角数字


# エラーメッセージ
ERROR_MESSAGE_SELECT_LIST = "Select an item from a list."   # （リストから選択してください）"
# ERROR_MESSAGE_PRICE_RANGE = "is out of setting range."   # （金額を正しく入力してください）"
# ERROR_MESSAGE_PRICE_WIDTH = "input Half-width number."   # （金額を正しく入力してください）"


# バリデーション（今回の実装では、コードの並び順がエラーメッセージの並び順に影響する）
  with_options presence: true do    # with_optionsで全てのバリデーションに共通したオプション（presence: true）をdo~endで指定したものに付ける
    validates :image
    validates :name
    validates :description
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  end
  # ActiveHashの選択が「--」の時は保存できないようにする
  with_options numericality: { other_than: 0, message: ERROR_MESSAGE_SELECT_LIST} do    # with_optionsで全てのバリデーションに共通したオプション（numericality: { other_than: 0 }）をdo~endで指定したものに付ける
    validates :category_id
    validates :condition_id
    validates :handling_time_id
    validates :postage_payer_id
    validates :prefecture_id
  end

end

