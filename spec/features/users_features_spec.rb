require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "新規登録" do
    before do
      visit new_user_registration_path
    end

    it "新規登録に成功すると、トップページに遷移してフラッシュメッセージが表示されること" do
      fill_in "メールアドレス", with: "hogehoge@gmail.com"
      fill_in "パスワード", with: "123456"
      fill_in "パスワード （確認用）", with: "123456"
      click_button "アカウント登録"
      expect(page).to have_content "アカウント登録が完了しました。"
      expect(current_path).to eq root_path
    end

    it "メールアドレスが空白の場合、新規登録に失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: "123456"
      fill_in "パスワード （確認用）", with: "123456"
      click_button "アカウント登録"
      expect(page).to have_content "エラーが発生したため ユーザー は保存されませんでした。"
      expect(current_path).to eq user_registration_path
    end

    it "メールアドレスが不正の場合、新規登録に失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: "hoge"
      fill_in "パスワード", with: "123456"
      fill_in "パスワード （確認用）", with: "123456"
      click_button "アカウント登録"
      expect(page).to have_content "エラーが発生したため ユーザー は保存されませんでした。"
      expect(current_path).to eq user_registration_path
    end

    it "パスワードが空白の場合、新規登録に失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: "hogehoge@gmail.com"
      fill_in "パスワード", with: ""
      fill_in "パスワード （確認用）", with: ""
      click_button "アカウント登録"
      expect(page).to have_content "エラーが発生したため ユーザー は保存されませんでした。"
      expect(current_path).to eq user_registration_path
    end

    it "パスワードが5文字以下の場合、新規登録に失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: "hogehoge@gmail.com"
      fill_in "パスワード", with: "12345"
      fill_in "パスワード （確認用）", with: "12345"
      click_button "アカウント登録"
      expect(page).to have_content "エラーが発生したため ユーザー は保存されませんでした。"
      expect(current_path).to eq user_registration_path
    end
  end

  describe "ログイン" do
    let!(:user) { create :user }
    let!(:other) { create :other }

    before do
      visit new_user_session_path
    end

    it "ログインに成功すると、トップページに遷移してフラッシュメッセージが表示されること" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      expect(page).to have_content "ログインしました。"
      expect(current_path).to eq root_path
    end

    it "メールアドレスが不正の場合、ログインに失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      expect(current_path).to eq new_user_session_path
    end

    it "パスワードが空白の場合、ログインに失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: ""
      click_button "ログイン"
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      expect(current_path).to eq new_user_session_path
    end

    it "パスワードが不正の場合、ログインに失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: other.password
      click_button "ログイン"
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      expect(current_path).to eq new_user_session_path
    end
  end

  describe "アカウント編集" do
    let!(:user) { create :user }
    let!(:other) { create :other }

    before do
      sign_in user
      visit edit_user_registration_path
    end

    it "メールアドレス変更に成功すると、トップページに遷移してフラッシュメッセージが表示されること" do
      fill_in "メールアドレス", with: "fugafuga@gmail.com"
      fill_in "パスワード", with: ""
      fill_in "パスワード （確認用）", with: ""
      fill_in "現在のパスワード", with: user.password
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました"
      expect(current_path).to eq root_path
    end

    it "パスワード変更に成功すると、トップページに遷移してフラッシュメッセージが表示されること" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "123456"
      fill_in "パスワード （確認用）", with: "123456"
      fill_in "現在のパスワード", with: user.password
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました"
      expect(current_path).to eq root_path
    end

    it "メールアドレスが不正の場合、更新に失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: "fugafuga"
      fill_in "パスワード", with: ""
      fill_in "パスワード （確認用）", with: ""
      fill_in "現在のパスワード", with: user.password
      click_button "更新"
      expect(page).to have_content "エラーが発生したため ユーザー は保存されませんでした。"
      expect(current_path).to eq user_registration_path
    end

    it "現在パスワードが空白の場合、更新に失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "123456"
      fill_in "パスワード （確認用）", with: "123456"
      fill_in "現在のパスワード", with: ""
      click_button "更新"
      expect(page).to have_content "エラーが発生したため ユーザー は保存されませんでした。"
      expect(current_path).to eq user_registration_path
    end

    it "パスワードが不正の場合、更新に失敗しエラーメッセージが表示されること" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "123456"
      fill_in "パスワード （確認用）", with: "123456"
      fill_in "現在のパスワード", with: other.password
      click_button "更新"
      expect(page).to have_content "エラーが発生したため ユーザー は保存されませんでした。"
      expect(current_path).to eq user_registration_path
    end
  end

  describe "ログアウト" do
    let!(:user) { create :user }

    before do
      sign_in user
      visit root_path
    end

    it "ログアウトすると、トップページに遷移してフラッシュメッセージが表示されること" do
      click_link "Logout"
      expect(page).to have_content "ログアウトしました。"
      expect(current_path).to eq root_path
    end
  end
end
