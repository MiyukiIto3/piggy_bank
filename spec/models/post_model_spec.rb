require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーションのテスト" do
    let!(:user) { create :user }
    let!(:kid) { create :kid, user: user }
    let!(:post) { create :post, user: user, kid: kid }

    it "正しいパラメータの場合、有効であること" do
      expect(post).to be_valid
    end

    it "dateがnilの場合、無効であること" do
      post.date = nil
      expect(post).not_to be_valid
    end

    it "dateが空白の場合、無効であること" do
      post.date = " "
      expect(post).not_to be_valid
    end

    it "post_typeがnilの場合、無効であること" do
      post.post_type = nil
      expect(post).not_to be_valid
    end

    it "post_typeが空白の場合、無効であること" do
      post.post_type = " "
      expect(post).not_to be_valid
    end

    it "amountがnilの場合、無効であること" do
      post.amount = nil
      expect(post).not_to be_valid
    end

    it "amountが空白の場合、無効であること" do
      post.amount = " "
      expect(post).not_to be_valid
    end

    it "amountが1の場合、有効であること" do
      post.amount = 1
      expect(post).to be_valid
    end

    it "amountが1より小さい場合、無効であること" do
      post.amount = 0
      expect(post).not_to be_valid
    end

    it "amountが小数の場合、無効であること" do
      post.amount = 1.1
      expect(post).not_to be_valid
    end

    it "descriptionがnilの場合、無効であること" do
      post.description = nil
      expect(post).not_to be_valid
    end

    it "descriptionが空白の場合、無効であること" do
      post.description = " "
      expect(post).not_to be_valid
    end
  end

  describe "リレーションのテスト" do
    context "user対postの関係" do
      it "１対多となっていること" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "kid対postの関係" do
      it "１対多となっていること" do
        expect(Post.reflect_on_association(:kid).macro).to eq :belongs_to
      end
    end
  end
end
