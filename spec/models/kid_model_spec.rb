require 'rails_helper'

RSpec.describe Kid, type: :model do
  describe "バリデーションのテスト" do
    let!(:user) { create :user }
    let!(:kid) { create :kid, user: user }

    it "正しいパラメータの場合、有効であること" do
      expect(kid).to be_valid
    end

    it "nameがnilの場合、無効であること" do
      kid.name = nil
      expect(kid).not_to be_valid
    end

    it "nameが空白の場合、無効であること" do
      kid.name = " "
      expect(kid).not_to be_valid
    end

    it "sexが選択されていない場合、無効であること" do
      kid.sex = nil
      expect(kid).not_to be_valid
    end

    it "targetがnilの場合、無効であること" do
      kid.target = nil
      expect(kid).not_to be_valid
    end

    it "targetが空白の場合、無効であること" do
      kid.target = " "
      expect(kid).not_to be_valid
    end

    it "target_amountがnilの場合、無効であること" do
      kid.target_amount = nil
      expect(kid).not_to be_valid
    end

    it "target_amountが空白の場合、無効であること" do
      kid.target_amount = " "
      expect(kid).not_to be_valid
    end

    it "target_amountが1の場合、有効であること" do
      kid.target_amount = 1
      expect(kid).to be_valid
    end

    it "target_amountが1より小さい場合、無効であること" do
      kid.target_amount = 0
      expect(kid).not_to be_valid
    end

    it "target_amountが小数の場合、無効であること" do
      kid.target_amount = 1.1
      expect(kid).not_to be_valid
    end
  end

  describe "リレーションのテスト" do
    context "user対kidの関係" do
      it "１対多となっている" do
        expect(Kid.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
