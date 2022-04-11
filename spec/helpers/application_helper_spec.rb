require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "page_full_title" do
    it "page_titleが空白の場合、BASE_TITLEが表示されること" do
      expect(page_full_title("")).to eq "Piggy Bank"
    end

    it "page_titleがnilの場合、BASE_TITLEが表示されること" do
      expect(page_full_title(nil)).to eq "Piggy Bank"
    end

    it "page_titleが存在する場合、タイトルが動的に表示されること" do
      expect(page_full_title("Page_title")).to eq "Page_title | Piggy Bank"
    end
  end
end
