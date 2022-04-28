require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "header" do
    context "ログインしてない場合" do
      before do
        get root_path
      end

      it "レスポンスが正常であること" do
        expect(response).to have_http_status(:success)
      end

      it "ログイン前のヘッダーリストであること" do
        expect(response.body).to include "Home"
        expect(response.body).to include "About"
        expect(response.body).to include "Signup"
        expect(response.body).to include "Login"
        expect(response.body).not_to include "Account"
        expect(response.body).not_to include "Kids"
        expect(response.body).not_to include "PiggyBank"
        expect(response.body).not_to include "Logout"
      end
    end

    context "ログイン中の場合" do
      let(:user) { create :user }

      before do
        sign_in user
        get root_path
      end

      it "レスポンスが正常であること" do
        expect(response).to have_http_status(:success)
      end

      it "ログイン後のヘッダーリストであること" do
        expect(response.body).to include "Home"
        expect(response.body).to include "About"
        expect(response.body).not_to include "Signup"
        expect(response.body).not_to include "Login"
        expect(response.body).to include "Account"
        expect(response.body).to include "Kids"
        expect(response.body).to include "PiggyBank"
        expect(response.body).to include "Logout"
      end
    end
  end

  describe "top" do
    let(:user) { create :user }

    context "ログインしていない場合" do
      before do
        get root_path
      end

      it "はじめるボタンが表示されないこと" do
        expect(response.body).not_to include "はじめる"
      end

      it "お子様登録ボタンが表示されないこと" do
        expect(response.body).not_to include "お子様登録"
      end

      it "ログインボタンが表示されること" do
        expect(response.body).to include "ログイン"
      end

      it "ゲストログインボタンが表示されること" do
        expect(response.body).to include "ゲストログイン"
      end
    end

    context "ログイン中かつ子供情報登録前の場合" do
      before do
        sign_in user
        get root_path
      end

      it "はじめるボタンが表示されないこと" do
        expect(response.body).not_to include "はじめる"
      end

      it "お子様登録ボタンが表示されること" do
        expect(response.body).to include "お子様登録"
      end

      it "ログインボタンが表示されないこと" do
        expect(response.body).not_to include "ログイン"
      end

      it "ゲストログインボタンが表示されないこと" do
        expect(response.body).not_to include "ゲストログイン"
      end
    end

    context "ログイン中かつ子供情報登録済みの場合" do
      let!(:kid) { create :kid, user: user }

      before do
        sign_in user
        get root_path
      end

      it "はじめるボタンが表示されること" do
        expect(response.body).to include "はじめる"
      end

      it "お子様登録ボタンが表示されないこと" do
        expect(response.body).not_to include "お子様登録"
      end

      it "ログインボタンが表示されないこと" do
        expect(response.body).not_to include "ログイン"
      end

      it "ゲストログインボタンが表示されないこと" do
        expect(response.body).not_to include "ゲストログイン"
      end
    end
  end

  describe "select_kid" do
    let(:user) { create :user }
    let(:kid) { create :kid, user: user }
    let!(:user_kids) { create_list(:kid, 2, user: user) }

    before do
      sign_in user
      get homes_select_kid_path
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "ユーザーの子供の名前が人数分表示されること" do
      user_kids[0..1].each do |user_kid|
        expect(response.body).to include user_kid.name
      end
    end
  end

  describe "select_kid" do
    let(:user) { create :user }
    let!(:kid) { create :kid, user: user }
    let!(:post_params) { attributes_for(:post) }

    before do
      sign_in user
      get homes_select_type_path params: { post: post_params }
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "投稿タイプ選択画面が表示されること" do
      expect(response.body).to include "お金をもらった"
      expect(response.body).to include "お金をつかった"
      expect(response.body).to include "貯金箱をみる"
    end
  end
end
