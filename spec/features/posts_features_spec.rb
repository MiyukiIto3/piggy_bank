require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let!(:user) { create :user }
  let!(:kid) { create :kid, user: user }
  let!(:post) { create :post, user: user, kid: kid }
  let!(:post_params) { attributes_for(:post) }

  describe "新規登録" do
    before do
      sign_in user
      visit new_post_path params: { post: post_params }
    end

    it "新規登録に成功すると、詳細確認画面に遷移してフラッシュメッセージが表示されること" do
      select "2022", from: "post_date_1i"
      select "1月", from: "post_date_2i"
      select "1", from: "post_date_3i"
      fill_in "post[amount]", with: 100
      fill_in "post[description]", with: "description"
      find('#post_post_type', visible: false).set("income")
      find('#post_user_id', visible: false).set(post.user_id)
      find('#post_kid_id', visible: false).set(post.kid_id)
      click_on "OK"
      expect(page).to have_content "登録しました。"
      expect(current_path).to eq post_path(post.id + 1)
    end

    it "入力が不正の場合、新規登録に失敗してエラーメッセージが表示されること" do
      select "2021", from: "post_date_1i"
      select "1月", from: "post_date_2i"
      select "1", from: "post_date_3i"
      fill_in "post[amount]", with: ""
      fill_in "post[description]", with: ""
      find('#post_post_type', visible: false).set("income")
      find('#post_user_id', visible: false).set(post.user_id)
      find('#post_kid_id', visible: false).set(post.kid_id)
      click_on "OK"
      expect(page).to have_content "「いくら」を入力してください"
      expect(page).to have_content "「いくら」は数値で入力してください"
      expect(page).to have_content "「せつめい」を入力してください"
      expect(current_path).to eq posts_path
    end
  end

  describe "編集" do
    before do
      sign_in user
      visit edit_post_path(post)
    end

    it "変更に成功すると、詳細確認画面に遷移してフラッシュメッセージが表示されること" do
      select "2022", from: "post_date_1i"
      select "2月", from: "post_date_2i"
      select "2", from: "post_date_3i"
      fill_in "post[amount]", with: 200
      fill_in "post[description]", with: "description2"
      click_on "OK"
      expect(page).to have_content "更新しました。"
      expect(current_path).to eq post_path(post)
    end

    it "入力が不正の場合、投稿更新に失敗してエラーメッセージが表示されること" do
      select "2022", from: "post_date_1i"
      select "1月", from: "post_date_2i"
      select "1", from: "post_date_3i"
      fill_in "post[amount]", with: ""
      fill_in "post[description]", with: ""
      click_on "OK"
      expect(page).to have_content "「いくら」を入力してください"
      expect(page).to have_content "「いくら」は数値で入力してください"
      expect(page).to have_content "「せつめい」を入力してください"
      expect(current_path).to eq post_path(post)
    end
  end
end
