require 'rails_helper'

RSpec.feature "Tops", type: :feature do
  describe "トップ画面" do
    context "ログインしてない場合" do
      before do
        visit root_path
      end

      it "Home リンク先が正しいこと" do
        click_link "Home"
        expect(current_path).to eq root_path
      end

      it "About リンク先が正しいこと"

      it "Signup リンク先が正しいこと" do
        click_link "Signup"
        expect(current_path).to eq new_user_registration_path
      end

      it "Login リンク先が正しいこと" do
        click_link "Login"
        expect(current_path).to eq new_user_session_path
      end
    end

    context "ログイン中の場合" do
      let(:user) { create :user }

      before do
        sign_in user
        visit root_path
      end

      it "Home リンク先が正しいこと" do
        click_link "Home"
        expect(current_path).to eq root_path
      end

      it "About リンク先が正しいこと"

      it "Account リンク先が正しいこと" do
        click_link "Account"
        expect(current_path).to eq users_account_path
      end

      it "Kids リンク先が正しいこと"

      it "Logout リンク先が正しいこと" do
        click_link "Logout"
        expect(current_path).to eq root_path
      end
    end
  end
end
