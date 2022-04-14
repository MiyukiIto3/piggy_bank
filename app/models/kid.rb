class Kid < ApplicationRecord
  enum sex: { 男の子: 0, 女の子: 1 }
end
