require 'rails_helper'

RSpec.describe "Kids", type: :request do
  let!(:user) { create :user }
  let!(:kid) { create :kid, user: user }
  let!(:user2) { create :user2 }
  let!(:kid2) { create :kid2, user: user2 }

  describe "一覧" do
    before do
      sign_in user
      get kids_path
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "ユーザーの子供情報だけが表示されること" do
      expect(response.body).to include kid.name
      expect(response.body).to include kid.sex
      expect(response.body).to include kid.target
      expect(response.body).to include kid.target_amount.to_s
    end

    it "他のユーザーの子供情報が表示されないこと" do
      expect(response.body).not_to include kid2.name
    end
  end

  describe "詳細" do
    before do
      sign_in user
      get kid_path(kid)
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "子供の詳細情報が表示されること" do
      expect(response.body).to include kid.name
      expect(response.body).to include kid.sex
      expect(response.body).to include kid.target
      expect(response.body).to include kid.target_amount.to_s
    end
  end

  describe "新規登録" do
    before do
      sign_in user
      get new_kid_path
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "編集" do
    before do
      sign_in user
      get edit_kid_path(kid)
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "入力フォームに子供の情報が表示されること" do
      expect(response.body).to include kid.name
      expect(response.body).to include kid.sex
      expect(response.body).to include kid.target
      expect(response.body).to include kid.target_amount.to_s
    end
  end
end
