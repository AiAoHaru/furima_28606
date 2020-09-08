require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  describe '#create' do
    before do
      @item_order = FactoryBot.build(:item_order)
    end

    it "入力フォーム全てに正しく値が存在すれば登録できること" do
      expect(@item_order).to be_valid
    end

    it "建物名が空でも登録できること" do
      @item_order.building_name = nil
      expect(@item_order).to be_valid
    end

    it "トークンが空では登録できないこと" do
      @item_order.token = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Token can't be blank")
    end

    it "郵便番号【zip_code】が空では登録できないこと" do
      @item_order.zip_code = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Zip code can't be blank")
    end

    it "都道府県【prefecture_id】が空では登録できないこと" do
      @item_order.prefecture_id = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it "市区町村【city】が空では登録できないこと" do
      @item_order.city = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("City can't be blank")
    end

    it "番地【house_number】が空では登録できないこと" do
      @item_order.house_number = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("House number can't be blank")
    end

    it "電話番号【phone_number】が空では登録できないこと" do
      @item_order.phone_number = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Phone number can't be blank")
    end

    # 正規表現が正しいかテスト（ハイフンの存在及び位置）
    it "郵便番号【zip_code】に「-（ハイフン）」 正しく入力（3桁-4桁）されていないと登録できないこと" do
      @item_order.zip_code = "1234567"or"1-234567"or"12-34567"or"1234-567"or"12345-67"or"123456-7"
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Zip code is invalid")
    end

    # 正規表現が正しいかテスト（半角数字のみかつ10~11桁以外）
    it "電話番号【phone_number】に正しく入力されていない（半角数字のみかつ10~11桁以外）ときは登録できないこと" do
      @item_order.phone_number = "012345678"or"012345678910"or"090-1234-5678"or"0123-45-6789"or"01-2345-5678"
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Phone number is invalid")
    end
  end
end
