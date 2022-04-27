require 'rails_helper'

RSpec.feature "Tops", type: :feature do
  describe "header" do
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

      it "Kids リンク先が正しいこと" do
        click_link "Kids"
        expect(current_path).to eq kids_path
      end

      it "Logout リンク先が正しいこと" do
        click_link "Logout"
        expect(current_path).to eq root_path
      end
    end
  end

  describe "top" do
    let(:user) { create :user }

    before do
      sign_in user
      visit root_path
    end

    it "はじめるボタン リンク先が正しいこと" do
      click_on "はじめる"
      expect(current_path).to eq homes_select_kid_path
    end
  end

  describe "select_kid" do
    let(:user) { create :user }
    let(:kid) { create :kid, user: user }
    let!(:user_kids) { create_list(:kid, 2, user: user) }

    before do
      sign_in user
      visit homes_select_kid_path
    end

    it "子供の名前ボタン リンク先が正しいこと" do
      first("button").click
      expect(current_path).to eq homes_select_type_path
    end
  end

  describe "select_kid" do
    let(:user) { create :user }
    let(:kid) { create :kid, user: user }
    let!(:post_params) { attributes_for(:post) }

    before do
      sign_in user
      visit homes_select_type_path params: { post: post_params }
    end

    it "お金をもらったボタン のリンク先が正しいこと" do
      click_on "お金をもらった"
      expect(current_path).to eq new_post_path
    end

    it "お金をつかったボタン のリンク先が正しいこと" do
      click_on "お金をつかった"
      expect(current_path).to eq new_post_path
    end
  end
end
