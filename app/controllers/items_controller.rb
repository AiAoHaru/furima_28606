class ItemsController < ApplicationController
  
  def index
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
      item = Item.find(params[:id])
      if item.destroy   # 削除が完了した時
        return redirect_to root_path
      else   # 削除に失敗した時
        redirect_to  :show
      end
    end
    
    def edit
    end
    
    def update
    end
    
    def show
      @item = Item.find(params[:id])
    end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :postage_payer_id, :prefecture_id,:handling_time_id, :price).merge(user_id: current_user.id)
  end

end
