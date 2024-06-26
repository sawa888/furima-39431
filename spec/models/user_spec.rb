require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録が出来るとき' do
      it '全項目の値が存在すれば登録出来る' do
        expect(@user).to be_valid
      end
      it 'メールアドレスが存在すれば登録出来る' do
        @user.email = 'test@test.com'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の半角英数字であれば登録出来る' do
        @user.password = 'aaa000'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'password_confirmatioがpasswordと同じであれば登録出来る' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'aaa000'
        expect(@user).to be_valid
      end
      it '苗字が全角(漢字)であれば登録出来る' do
        @user.first_name = '山田'
        expect(@user).to be_valid
      end
      it '苗字が全角(カタナカ)であれば登録出来る' do
        @user.first_name = 'ヤマダ'
        expect(@user).to be_valid
      end
      it '苗字が全角(ひらがな)であれば登録出来る' do
        @user.first_name = 'やまだ'
        expect(@user).to be_valid
      end
      it '名前が全角(漢字)であれば登録出来る' do
        @user.last_name = '太郎'
        expect(@user).to be_valid
      end
      it '名前が全角(カタナカ)であれば登録出来る' do
        @user.last_name = 'タロウ'
        expect(@user).to be_valid
      end
      it '名前が全角(ひらがな)であれば登録出来る' do
        @user.last_name = 'タロウ'
        expect(@user).to be_valid
      end
      it '苗字カナが全角カタカナであれば登録出来る' do
        @user.first_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
      it '名前カナが全角カタカナであれば登録出来' do
        @user.last_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
      it '生年月日が存在すれば登録出来る' do
        @user.birth_day = '1971-09-11'
        expect(@user).to be_valid
      end
    end
    context '新規登録が出来ない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに"@"が含まれていないと登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録出来ない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password",
                                                      'Password  is invalid. Include both letters and numbers')
      end
      it 'passwordが6文字以下では登録出来ない' do
        @user.password = 'aa00'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが6文字以上の英数字でないと登録出来ない' do
        @user.password = 'aa00'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password",
                                                      'Password is too short (minimum is 6 characters)')
      end
      it 'passwordが6文字以上の数字のみでは登録出来ない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password",
                                                      'Password  is invalid. Include both letters and numbers')
      end
      it 'passwordが6文字以上の英字のみでは登録出来ない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password",
                                                      'Password  is invalid. Include both letters and numbers')
      end
      it '6文字以上の全角を含むpasswordでは登録出来ない' do
        @user.password = '山田aaa000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password",
                                                      'Password  is invalid. Include both letters and numbers')
      end
      it 'password_confirmationが存在していないと登録出来ない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'password_confirmationとpasswordが一致していないと登録出来ない' do
        @user.password = 'aaa000'
        @user.password = 'bbb111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '苗字(全角)が空では登録出来ない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank",
                                                      'First name is invalid. Input full-width characters')
      end
      it '名前(全角)が空では登録出来ない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank",
                                                      'Last name is invalid. Input full-width characters')
      end
      it '苗字(全角)が全角以外では登録出来ない' do
        @user.first_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end
      it '名前(全角)が全角以外では登録出来ない' do
        @user.last_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
      end
      it '苗字カナが空では登録出来ない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名前カナが空では登録出来ない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '苗字カナが全角以外では登録出来ない' do
        @user.first_name_kana = 'yamada 山田 ﾔﾏﾀﾞやまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end
      it '名前カナが全角以外では登録出来ない' do
        @user.last_name_kana = 'tarou 太郎 ﾀﾛｳ たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
      end
      it '生年月日が空では登録出来ない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
