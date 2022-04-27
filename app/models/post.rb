class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :kid_id, presence: true
  validates :date, presence: true
  validates :post_type, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :description, presence: true

  belongs_to :user
  belongs_to :kid
end
