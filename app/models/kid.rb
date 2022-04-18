class Kid < ApplicationRecord
  validates :name, presence: true
  validates :sex, presence: true
  validates :target, presence: true
  validates :target_amount, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}

  has_one_attached :image
  enum sex: { 男の子: 0, 女の子: 1 }

  belongs_to :user
end
