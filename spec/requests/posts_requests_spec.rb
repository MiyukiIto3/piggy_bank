require 'rails_helper'

RSpec.describe "Posts", type: :request do
  # ログインユーザーの選択中の子供の投稿（income）
  let!(:user) { create :user }
  let!(:kid) { create :kid, user: user }
  let!(:post) { create :post, user: user, kid: kid }

  # ログインユーザーの他の子供の投稿
  let!(:kid2) { create :kid2, user: user }
  let!(:post2)  { create :post2, user: user, kid: kid2 }

  # 他のユーザーの子供の投稿
  let!(:user2) { create :user2 }
  let!(:kid3) { create :kid3, user: user2 }
  let!(:post3)  { create :post3, user: user2, kid: kid3 }

  # ログインユーザーの選択中の子供の投稿（outgo）
  let!(:post4) { create :post4, user: user, kid: kid }

  describe "一覧" do
    before do
      sign_in user
      get posts_path, params: {
        post: {
          user_id: post.user_id,
          kid_id: post.kid_id,
          date: post.date,
          post_type: post.post_type,
          amount: post.amount,
          description: post.description,
        },
      }
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "子供の名前が表示されること" do
      expect(response.body).to include post.kid.name
    end

    it "子供の欲しいものが表示されること" do
      expect(response.body).to include post.kid.target
    end

    it "子供の所持金額が表示されること" do
      expect(response.body).to include "9,600円"
    end

    it "投稿一覧にユーザーの子供１人分の投稿が表示されること" do
      expect(response.body).to include I18n.l(post.date, format: :short)
      expect(response.body).to include "ふえた"
      expect(response.body).to include post.amount.to_s(:delimited)
      expect(response.body).to include post.description
      expect(response.body).to include I18n.l(post4.date, format: :short)
      expect(response.body).to include "へった"
      expect(response.body).to include post4.amount.to_s(:delimited)
      expect(response.body).to include post4.description
    end

    it "投稿一覧にユーザーの他の子供の投稿が表示されないこと" do
      expect(response.body).not_to include post2.amount.to_s(:delimited)
    end

    it "投稿一覧に他のユーザーの子供の投稿が表示されないこと" do
      expect(response.body).not_to include post3.amount.to_s(:delimited)
    end
  end

  describe "詳細" do
    before do
      sign_in user
      get post_path(post)
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "投稿の詳細情報が表示されること" do
      expect(response.body).to include I18n.l(post.date)
      expect(response.body).to include post.amount.to_s(:delimited)
      expect(response.body).to include "ふえた"
      expect(response.body).to include post.description
    end
  end

  describe "新規登録" do
    before do
      sign_in user
      get new_post_path, params: {
        post: {
          user_id: post.user_id,
          kid_id: post.kid_id,
          date: post.date,
          post_type: post.post_type,
          amount: post.amount,
          description: post.description,
        },
      }
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "編集" do
    before do
      sign_in user
      get edit_post_path(post)
    end

    it "レスポンスが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "入力フォームに投稿の情報が表示されること" do
      expect(response.body).to include post.date.year.to_s
      expect(response.body).to include post.date.month.to_s
      expect(response.body).to include post.date.day.to_s
      expect(response.body).to include post.amount.to_s
      expect(response.body).to include post.post_type
      expect(response.body).to include post.description
    end
  end
end
