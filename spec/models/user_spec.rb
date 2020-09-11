require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "入力フォーム全てに正しく値が存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nicknameが空では登録できないこと" do
      @user.nickname = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Nickname can't be blank")
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Email can't be blank")
      expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
    end

    it "passwordが空では登録できないこと" do
      @user.password = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      @user.password_confirmation = ""
      @user.valid?
      # expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it "お名前(全角)【family_name】が空では登録できないこと" do
      @user.family_name = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Family name can't be blank")
      expect(@user.errors.full_messages).to include("お名前(全角)を入力してください")
    end
    
    it "お名前(全角)【last_name】が空では登録できないこと" do
      @user.last_name = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Last name can't be blank")
      expect(@user.errors.full_messages).to include("お名前(全角)を入力してください")
    end

    it "お名前カナ(全角)【family_name_reading】が空では登録できないこと" do
      @user.family_name = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Family name can't be blank")
      expect(@user.errors.full_messages).to include("お名前(全角)を入力してください")
    end

    it "お名前カナ(全角)【last_name_reading】が空では登録できないこと" do
      @user.last_name = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Last name can't be blank")
      expect(@user.errors.full_messages).to include("お名前(全角)を入力してください")
    end

    it "生年月日【Birth_date】が空では登録できないこと" do
      @user.birth_date = nil
      @user.valid?
      # expect(@user.errors.full_messages).to include("Birth date can't be blank")
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end

    it "passwordが半角数字のみでは登録できないこと" do
      @user.password = "12345678910"
      @user.password_confirmation = "12345678910"
      @user.valid?
      # expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers.")
      expect(@user.errors.full_messages).to include("パスワード半角英数字混合で入力してください")
    end

    it "passwordが半角英字のみでは登録できないこと" do
      @user.password = "abcdefghij"
      @user.password_confirmation = "abcdefghij"
      @user.valid?
      # expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers.")
      expect(@user.errors.full_messages).to include("パスワード半角英数字混合で入力してください")
    end

    it "passwordが半角英数字混合であれば登録できること" do
      @user.password = "1a2b3c4d5e6f7g8h9i10j"
      @user.password_confirmation = "1a2b3c4d5e6f7g8h9i10j"
      expect(@user).to be_valid
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.password = "1a2b3c"
      @user.password_confirmation = "1a2b3c"
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "1a2b3"
      @user.valid?
      # expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      # expect(another_user.errors.full_messages).to include("Email has already been taken")
      expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
    end

# 正規表現が正しいかテストのため、１つパターンを実行（全角英字でテスト）
    it "お名前(全角)【family_name】が全角（全角ひらがな、全角カタカナ、漢字）でない場合は登録できないこと" do
      @user.family_name = "ＳＵＺＵＫＩ"
      @user.valid?
      # expect(@user.errors.full_messages).to include("Family name is invalid. Input Full-width characters.")
      expect(@user.errors.full_messages).to include("お名前(全角)全角で入力してください")
    end
# 正規表現が正しいかテストのため、１つパターンを実行（全角英字でテスト）
    it "お名前(全角)【last_name】が全角（全角ひらがな、全角カタカナ、漢字）でない場合は登録できないこと" do
      @user.last_name = "ＩＣＨＩＲＯ"
      @user.valid?
      # expect(@user.errors.full_messages).to include("Last name is invalid. Input Full-width characters.")
      expect(@user.errors.full_messages).to include("お名前(全角)全角で入力してください")
    end
# 正規表現が正しいかテストのため、１つパターンを実行（半角カナでテスト）
    it "お名前カナ(全角)【family_name_reading】が全角カナでない場合は登録できないこと" do
      @user.family_name_reading = "ｽｽﾞｷ"
      @user.valid?
      # expect(@user.errors.full_messages).to include("Family name reading is invalid. Input Full-width katakana characters.")
      expect(@user.errors.full_messages).to include("お名前カナ(全角)全角カナで入力してください")
    end
# 正規表現が正しいかテストのため、１つパターンを実行（半角カナでテスト）
    it "お名前カナ(全角)【last_name_reading】が全角カナでない場合は登録できないこと" do
      @user.last_name_reading = "ｲﾁﾛｳ"
      @user.valid?
      # expect(@user.errors.full_messages).to include("Last name reading is invalid. Input Full-width katakana characters.")
      expect(@user.errors.full_messages).to include("お名前カナ(全角)全角カナで入力してください")
    end
  end
end
