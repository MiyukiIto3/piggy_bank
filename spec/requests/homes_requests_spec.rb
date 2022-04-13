require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "トップ" do
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
        expect(response.body).to include "Logout"
      end
    end
  end
end
