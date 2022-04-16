class Kid < ApplicationRecord
  has_one_attached :image
  enum sex: { 男の子: 0, 女の子: 1 }

  belongs_to :user
end
