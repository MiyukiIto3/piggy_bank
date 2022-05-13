require 'rails_helper'

RSpec.describe KidsHelper, type: :helper do
  describe "子供の敬称" do
    it "男の子の場合、くん" do
      expect(kid_honorific("男の子")).to eq "くん"
    end

    it "女の子の場合、ちゃん" do
      expect(kid_honorific("女の子")).to eq "ちゃん"
    end
  end
end
