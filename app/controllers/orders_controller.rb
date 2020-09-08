class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create, :pay_item, :not_buyer]
  before_action :not_buyer, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @order = ItemOrder.new   # エラーメッセージ表示のための@orderを定義
  end

  def create
    @order = ItemOrder.new(order_params)
    if @order.valid?   # バリデーションをクリアした時
      @order.save
      pay_item
      return redirect_to root_path
    else
      render :index    # バリデーションに弾かれた時
    end
  end

  private

  def order_params
    params.require(:item_order).permit(:token, :zip_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :purchaser_id).merge(user_id: current_user.id, item_id: params[:item_id], )   # :tokenとは、card.jsで定義しているname属性のこと
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]   # PAY.JPテスト秘密鍵（環境変数）
    Payjp::Charge.create(
      amount: @item.price,     # 商品の値段
      card: params[:token],    # カードトークン
      currency:'jpy'           # 通貨の種類(日本円)
    )
  end

  # before_action
  def set_item
    @item = Item.find(params[:item_id]) 
  end

  # before_action（本人 & 購入済み商品の直リンクでの購入禁止）
  def not_buyer
    if current_user.id == @item.user_id || Purchaser.find_by(item_id: params[:item_id]) != nil
      redirect_to root_path 
    end
  end

  # before_action（未ログインの場合の対応）
  def move_to_index
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

end
