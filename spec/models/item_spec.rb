require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end

    it "imageと入力項目の全てが存在していれば登録できること" do
      expect(@item).to be_valid
    end

    it "image（商品写真）が空では登録できないこと" do
      @item.image = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Image can't be blank")
      expect(@item.errors.full_messages).to include("出品画像を入力してください")
    end

    it "name（商品名）が空では登録できないこと" do
      @item.name = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Name can't be blank")
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end

    it "description(説明)が空では登録できないこと" do
      @item.description = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Description can't be blank")
      expect(@item.errors.full_messages).to include("商品の説明を入力してください")
    end

    it "category（カテゴリー）が空では登録できないこと" do
      @item.category = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Category Select an item from a list.")
      expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
    end

    it "condition（商品の状態）が空では登録できないこと" do
      @item.condition = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Condition Select an item from a list.")
      expect(@item.errors.full_messages).to include("商品の状態を選択してください")
    end

    it "postage_payer（配送料の負担）が空では登録できないこと" do
      @item.postage_payer = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Postage payer Select an item from a list.")
      expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
    end

    it "prefecture（発送元の地域）が空では登録できないこと" do
      @item.prefecture = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Prefecture Select an item from a list.")
      expect(@item.errors.full_messages).to include("都道府県を選択してください")
    end

    it "handling_time（発送までの日数）が空では登録できないこと" do
      @item.handling_time = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Handling time Select an item from a list.")
      expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
    end

    it "price（販売価格）が空では登録できないこと" do
      @item.price = nil
      @item.valid?
      # expect(@item.errors.full_messages).to include("Price can't be blank")
      expect(@item.errors.full_messages).to include("金額を入力してください")
    end

    it "price（販売価格）が300円未満では登録できないこと" do
      @item.price = 299
      @item.valid?
      # expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      expect(@item.errors.full_messages).to include("金額は300以上の値にしてください")
    end

    it "price（販売価格）が10,000,000円以上では登録できないこと" do
      @item.price = 10000000
      @item.valid?
      # expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      expect(@item.errors.full_messages).to include("金額は9999999以下の値にしてください")
    end

    it "price（販売価格）が半角数字以外では登録できないこと" do
      @item.price = "１０００"
      @item.valid?
      # expect(@item.errors.full_messages).to include("Price is not a number")
      expect(@item.errors.full_messages).to include("金額は数値で入力してください")
    end
  end
end