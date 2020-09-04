class ItemsController < ApplicationController
  
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, except: [:index, :show]
  before_action :corrent_user, only: [:destroy, :edit, :update]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item =  Item.new(item_params)
    if @item.valid?   # バリデーションをクリアした時
      @item.save
      return redirect_to root_path
    else
      render :new    # バリデーションに弾かれた時
    end
  end
  
  def destroy
    if @item.destroy   # 削除が完了した時
      return redirect_to root_path
    else   # 削除に失敗した時
      redirect_to  :show
    end
  end
  
  def edit
  end
  
  def update
    if  @item.update(item_params)   # updateが成功した時
      return redirect_to item_path
    else
      render :edit   # updateが失敗した時
    end
  end
  
  def show
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :postage_payer_id, :prefecture_id,:handling_time_id, :price).merge(user_id: current_user.id)
  end

  # before_action
  def set_item
    @item = Item.find(params[:id])
  end

  # before_action（未ログインの場合の対応）
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
  # before_action（本人以外の直リンクを禁止）
  def corrent_user
    if current_user.id != @item.user_id
      redirect_to root_path 
    end
  end
end
