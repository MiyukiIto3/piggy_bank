require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "新規登録" do
    before do
      get new_user_registration_path
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "新規登録画面が表示されること" do
      expect(response.body).to include "アカウント登録"
    end

    it "新規登録画面が日本語であること" do
      expect(response.body).to include "メールアドレス"
      expect(response.body).to include "パスワード"
      expect(response.body).to include "パスワード （確認用）"
      expect(response.body).to include "アカウント登録"
      expect(response.body).to include "ログイン"
    end
  end

  describe "ログイン" do
    before do
      get new_user_session_path
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "ログイン画面が表示されること" do
      expect(response.body).to include "ログイン"
    end

    it "ログイン画面が日本語であること" do
      expect(response.body).to include "メールアドレス"
      expect(response.body).to include "パスワード"
      expect(response.body).to include "ログイン"
      expect(response.body).to include "アカウント登録"
    end
  end

  describe "アカウント確認" do
    let!(:user) { create :user }
    let!(:other) { create :other }

    before do
      sign_in user
      get users_account_path
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "アカウント確認画面が表示されること" do
      expect(response.body).to include "アカウント"
      expect(response.body).to include user.email
      expect(response.body).not_to include other.email
    end
  end

  describe "アカウント編集" do
    let(:user) { create :user }

    before do
      sign_in user
      get edit_user_registration_path
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "ユーザー編集画面が表示されること" do
      expect(response.body).to include "ユーザー編集"
    end

    it "ユーザー編集画面が日本語であること" do
      expect(response.body).to include "メールアドレス"
      expect(response.body).to include "パスワード"
      expect(response.body).to include "パスワード （確認用）"
      expect(response.body).to include "現在のパスワード"
      expect(response.body).to include "更新"
      expect(response.body).to include "戻る"
    end
  end
end
