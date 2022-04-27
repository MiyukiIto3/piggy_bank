require 'rails_helper'

RSpec.feature "Kids", type: :feature do
  let!(:user) { create :user }
  let!(:kid) { create :kid, user: user }

  describe "新規登録" do
    before do
      sign_in user
      visit new_kid_path
    end

    it "新規登録に成功すると、詳細確認画面に遷移してフラッシュメッセージが表示されること" do
      fill_in "kid[name]", with: "kid_name"
      choose "kid_sex_男の子"
      fill_in "kid[target]", with: "target"
      fill_in "kid[target_amount]", with: 1000
      click_on "登録"
      expect(page).to have_content "登録しました。"
    end

    it "入力が不正の場合、新規登録に失敗してエラーメッセージが表示されること" do
      fill_in "kid[name]", with: ""
      fill_in "kid[target]", with: ""
      fill_in "kid[target_amount]", with: ""
      click_on "登録"
      expect(page).to have_content "名前を入力してください"
      expect(page).to have_content "性別を入力してください"
      expect(page).to have_content "欲しいものを入力してください"
      expect(page).to have_content "目標金額を入力してください"
      expect(page).to have_content "目標金額は数値で入力してください"
      expect(current_path).to eq kids_path
    end
  end

  describe "編集" do
    before do
      sign_in user
      visit edit_kid_path(kid)
    end

    it "子供情報変更に成功すると、詳細確認画面に遷移してフラッシュメッセージが表示されること" do
      fill_in "kid[name]", with: "kid_name2"
      choose "kid_sex_女の子"
      fill_in "kid[target]", with: "target2"
      fill_in "kid[target_amount]", with: 2000
      click_on "登録"
      expect(page).to have_content "更新しました。"
    end

    it "入力が不正の場合、子供情報変更に失敗してエラーメッセージが表示されること" do
      fill_in "kid[name]", with: ""
      fill_in "kid[target]", with: ""
      fill_in "kid[target_amount]", with: ""
      click_on "登録"
      expect(page).to have_content "名前を入力してください"
      expect(page).to have_content "欲しいものを入力してください"
      expect(page).to have_content "目標金額を入力してください"
      expect(page).to have_content "目標金額は数値で入力してください"
      expect(current_path).to eq kid_path(kid)
    end
  end

  describe "削除" do
    before do
      sign_in user
      visit kids_path
    end

    it "削除ボタンを押すと、子供情報が削除されてメッセージが表示されること" do
      click_on "削除"
      expect(page).to have_content "削除しました。"
      expect(current_path).to eq kids_path
    end
  end
end
