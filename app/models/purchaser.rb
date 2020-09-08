class Purchaser < ApplicationRecord
# アソシエーション
  belongs_to :user
  belongs_to :item
  has_one :address, dependent: :destroy   # 購入済みの商品（Item）について、出品者が削除した場合に、購入者情報（Purchaser）に紐付いている配送先情報（Address）も一緒に削除させる設定

  
end
