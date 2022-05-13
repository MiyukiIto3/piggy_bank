require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションのテスト" do
    let!(:user) { create :user }

    it "正しいパラメータの場合、有効であること" do
      expect(user).to be_valid
    end

    it "emailがnilの場合、無効であること" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "emailが空白の場合、無効であること" do
      user.email = " "
      expect(user).not_to be_valid
    end

    it "emailが重複する場合、無効であること" do
      user2 = User.new(email: user.email)
      expect(user2).not_to be_valid
    end

    it "passwordがnilの場合、無効であること" do
      user.password = nil
      expect(user).not_to be_valid
    end

    it "passwordが空白の場合、無効であること" do
      user.password = " "
      expect(user).not_to be_valid
    end

    it "passwordが5文字の場合、無効であること" do
      user.password = "a" * 5
      expect(user).not_to be_valid
    end

    it "passwordが文6字の場合、有効であること" do
      user.password = "a" * 6
      user.password_confirmation = "a" * 6
      expect(user).to be_valid
    end

    it "passwordが128文字の場合、有効であること" do
      user.password = "a" * 128
      user.password_confirmation = "a" * 128
      expect(user).to be_valid
    end

    it "passwordが文129字の場合、無効であること" do
      user.password = "a" * 129
      expect(user).not_to be_valid
    end
  end

  describe "リレーションのテスト" do
    context "user対kidの関係" do
      it "1対多となっていること" do
        expect(User.reflect_on_association(:kids).macro).to eq :has_many
      end
    end

    context "user対postの関係" do
      it "1対多となっていること" do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
